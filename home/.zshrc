__source_if_exists() {
  # sources a file if it exists
  [[ -f "$1" ]] && source "$1"
}
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
__source_if_exists "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(ssh-agent git osx vagrant docker)

# Color correct paths rather than underlining them.
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

# Load SSH identities
zstyle :omz:plugins:ssh-agent identities id_rsa

# Add custom completion scripts
fpath=(~/.zsh/completion $fpath)

# Start oh-my-zsh
source $ZSH/oh-my-zsh.sh

# PATH modifications. Don't modify if we're in TMUX because path_helper does it for us.
if [[ -z $TMUX ]]; then
  # Add ~/.bin to PATH
  if ! [[ $PATH =~ "$HOME/.bin" ]]; then export PATH="$PATH:$HOME/.bin"; fi
  # Add homebrew's sbin dir to PATH
  if ! [[ $PATH =~ '/usr/local/sbin' ]]; then export PATH="/usr/local/sbin:$PATH"; fi
fi

# Initialize rbenv
# I modifed /etc/zprofile as shown here https://pgib.me/blog/2013/10/11/macosx-tmux-zsh-rbenv/
# to prevent rbenv from ending up at the end of PATH.
if type rbenv >/dev/null ; then
  if [[ $PATH =~ 'rbenv/shims' ]]; then
    #eval "$(rbenv init - | sed '/PATH/d')" # Prevent rbenv ending up in PATH twice.
  else
    eval "$(rbenv init -)"
  fi
fi

# Source my external alias config
# NOTE about 'ls': If coreutils is installed, oh-my-zsh will alias ls to gls, but
#                  something about it is broken which breaks ls. not sure...
source $HOME/.aliases

# Setup thefuck
eval $(thefuck --alias)

if [[ -f $HOME/.ripgreprc ]]; then
  export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
fi

# kubectl shell completion
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi

__source_if_exists /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export EDITOR='nvim'

if [[ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]]; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  if ! [[ $PATH =~ 'google-cloud-sdk' ]]; then source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc; fi
fi

# Don't share history between zsh sessions.
unsetopt share_history

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
__source_if_exists ~/.p10k.zsh

# Customizations to the p10k prompt (this must be after source ~/.p10k.zsh)
POWERLEVEL9K_STATUS_OK=false  # Only show return code status on failure, not success.
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=("${(@)POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS:#command_execution_time}") # Remove the 'command_execution_time' prompt segment.
