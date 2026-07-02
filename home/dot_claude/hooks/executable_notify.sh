#!/bin/bash
# Claude Code notification hook
# Uses WezTerm's OSC 777 escape sequence for native notifications that focus WezTerm on click.
# Falls back to osascript for non-WezTerm terminals.

TITLE="Claude Code"
BODY="Waiting for your input"

# Read hook JSON from stdin and extract context from the transcript.
if command -v jq &>/dev/null; then
  input=$(cat)
  transcript_path=$(echo "$input" | jq -r '.transcript_path // empty' 2>/dev/null)

  if [[ -n "$transcript_path" && -f "$transcript_path" ]]; then
    extract_context() {
      # First choice: find the last AskUserQuestion tool call — join multiple questions with " / "
      local ctx
      ctx=$(tail -30 "$transcript_path" | jq -rs \
        '[.[] | select(.type == "assistant") | .message.content[]?
           | select(.type == "tool_use" and .name == "AskUserQuestion")
           | .input.questions | map(.question) | join(" / ")] | last // empty' \
        2>/dev/null)

      # Second choice: last plain assistant text message
      if [[ -z "$ctx" ]]; then
        ctx=$(tail -30 "$transcript_path" | jq -rs \
          '[.[] | select(.type == "assistant") | .message.content[]?
             | select(.type == "text") | .text] | last // empty' \
          2>/dev/null)
      fi
      echo "$ctx"
    }

    # The hook fires async, right as Claude Code writes the transcript line that
    # triggered it — occasionally we read the file before that write lands, so
    # retry briefly rather than falling back to the generic default.
    context=""
    for attempt in 1 2 3 4; do
      context=$(extract_context)
      [[ -n "$context" ]] && break
      sleep 0.15
    done

    if [[ -n "$context" ]]; then
      # Trim whitespace and truncate to fit a notification
      context=$(echo "$context" | tr -s '[:space:]' ' ' | sed 's/^ //;s/ $//')
      if [[ ${#context} -gt 120 ]]; then
        BODY="${context:0:117}..."
      else
        BODY="$context"
      fi
    fi
  fi
fi

send_osc() {
  local tty_dev="$1"
  printf '\033]777;notify;%s;%s\007' "$TITLE" "$BODY" > "$tty_dev"
}

# Walk up the process tree to find the first ancestor with a tty device.
# This handles cases where /dev/tty isn't the controlling terminal of the
# subprocess (e.g. if Node spawns hooks without inheriting the pty directly).
find_parent_tty() {
  local pid=$$
  while [[ $pid -gt 1 ]]; do
    local tty_name
    tty_name=$(ps -p "$pid" -o tty= 2>/dev/null | tr -d ' ')
    if [[ -n "$tty_name" && "$tty_name" != "??" ]]; then
      echo "/dev/$tty_name"
      return 0
    fi
    pid=$(ps -p "$pid" -o ppid= 2>/dev/null | tr -d ' ')
  done
  return 1
}

if [[ -n "$WEZTERM_PANE" || "$TERM_PROGRAM" == "WezTerm" ]]; then
  # Prefer /dev/tty (the controlling terminal of this process).
  # OSC 777 is WezTerm's native notification sequence — WezTerm intercepts it
  # and sends a native macOS notification that focuses WezTerm on click.
  if [[ -w /dev/tty ]]; then
    send_osc /dev/tty
  else
    tty_dev=$(find_parent_tty)
    if [[ -n "$tty_dev" && -w "$tty_dev" ]]; then
      send_osc "$tty_dev"
    else
      osascript -e "display notification \"$BODY\" with title \"$TITLE\" sound name \"Ping\""
    fi
  fi
else
  osascript -e "display notification \"$BODY\" with title \"$TITLE\" sound name \"Ping\""
fi

# Escapes backslashes and double quotes for embedding in an AppleScript string literal.
osa_escape() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

# WezTerm's frontmost process name is "wezterm-gui", not "WezTerm" — verified via
# `osascript -e 'tell application "System Events" to get name of every process'`.
frontmost=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null)

if [[ "$frontmost" != "wezterm-gui" ]]; then
  ESC_TITLE=$(osa_escape "$TITLE")
  ESC_BODY=$(osa_escape "$BODY")
  # Backgrounded so the hook returns immediately; the dialog waits for a click
  # or times out on its own, independent of the hook's lifecycle.
  (
    osascript \
      -e "beep 2" \
      -e "tell application \"System Events\"" \
      -e "activate" \
      -e "display dialog \"$ESC_BODY\" with title \"$ESC_TITLE\" buttons {\"OK\"} default button \"OK\" giving up after 60 with icon caution" \
      -e "end tell" \
      >/dev/null 2>&1
  ) &
  disown
fi
