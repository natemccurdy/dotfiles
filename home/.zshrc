# Utility functions
__source_if_exists() {
  [[ -f "$1" ]] && source "$1"
}

# Basic settings and environment variables
export ZSH=$HOME/.oh-my-zsh
export EDITOR='nvim'
export HISTFILE="$HOME/.zsh_history"
export HOMEBREW_NO_ANALYTICS=true

# Path settings
export PATH="$PATH:$HOME/.bin"
export GOPATH="${HOME}/src/go"
export PATH="${PATH}:${GOPATH}/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Add homebrew's bin dir to PATH
[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Add homebrew's completions to zsh. Must be before sourcing oh-my-zsh.sh
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Oh-my-zsh setup
# Prevent slow copy/paste of long commands with oh-my-zsh. Must be before
# sourcing oh-my-zsh.sh https://github.com/ohmyzsh/ohmyzsh/issues/6338
DISABLE_MAGIC_FUNCTIONS=true
ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS=true
plugins=(ssh-agent)
source $ZSH/oh-my-zsh.sh

# Theme and prompt customization
__source_if_exists ~/.p10k.zsh
POWERLEVEL9K_STATUS_OK=false

# Custom Powerlevel10k prompt segment for $VAULT_ADDR
function prompt_my_vault_addr() {
  if [[ -n $VAULT_ADDR ]]; then
    p10k segment -i 'LOCK_ICON' -r -f black -b cyan -t "$VAULT_ADDR"
  fi
}
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS+=my_vault_addr
typeset -g POWERLEVEL9K_MY_VAULT_ADDR_SHOW_ON_COMMAND='vault'

# Aliases and external configurations
source $HOME/.aliases

if [[ -f $HOME/.ripgreprc ]]; then
  export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
fi

# SSH identities
zstyle :omz:plugins:ssh-agent identities id_ed25519 id_rsa

# Kubernetes and kubectl settings
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi
if type compdef >/dev/null; then
  compdef kubecolor=kubectl
fi

# Load additional configs from Homebrew-supplied tools.
__source_if_exists $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
__source_if_exists $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
__source_if_exists $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
__source_if_exists ~/.config/wezterm/wezterm.sh # Wezterm shell-integration

# FZF key bindings and settings
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --hidden'

# rbenv initialization
if type rbenv >/dev/null; then
  eval "$(rbenv init -)"
fi

# direnv initialization
if type direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi

# Highlight command paths with color instead of underlines.
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

# Prevent duplicate entries in PATH. Must be after any PATH modifications.
typeset -U path

# Disable auto-cd
unsetopt autocd
