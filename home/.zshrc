__source_if_exists() {
  # sources a file if it exists
  [[ -f "$1" ]] && source "$1"
}
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
#__source_if_exists "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

# Prevent slow copy/paste of long commands: https://github.com/ohmyzsh/ohmyzsh/issues/6338
DISABLE_MAGIC_FUNCTIONS=true

export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(gitfast macos vagrant docker ssh-agent)

# Modern docker completion is missing things like image names and container
# names. Revert to the legacy omz-provided completion for now.
# This must be before: source $ZSH/oh-my-zsh.sh
# https://github.com/ohmyzsh/ohmyzsh/issues/11817
zstyle ':omz:plugins:docker' legacy-completion yes

# Color correct paths rather than underlining them.
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

# Load SSH identities
zstyle :omz:plugins:ssh-agent identities id_rsa

# Add custom completion scripts
fpath=(~/.zsh/completion $fpath)

# Start oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Add ~/.bin to PATH
if ! [[ $PATH =~ "$HOME/.bin" ]]; then export PATH="$PATH:$HOME/.bin"; fi
# Add homebrew's sbin dir to PATH
if ! [[ $PATH =~ '/usr/local/sbin' ]]; then export PATH="/usr/local/sbin:$PATH"; fi

# Initialize rbenv
if type rbenv >/dev/null ; then
  eval "$(rbenv init -)"
fi

# Source my external alias config
# NOTE about 'ls': If coreutils is installed, oh-my-zsh will alias ls to gls, but
#                  something about it is broken which breaks ls. not sure...
source $HOME/.aliases

if [[ -f $HOME/.ripgreprc ]]; then
  export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
fi

# kubectl shell completion
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi

__source_if_exists /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export EDITOR='nvim'

__source_if_exists /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
__source_if_exists /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

# Don't share history between zsh sessions.
unsetopt share_history

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
__source_if_exists ~/.p10k.zsh

# Customizations to the p10k prompt (this must be after source ~/.p10k.zsh)
POWERLEVEL9K_STATUS_OK=false  # Only show return code status on failure, not success.
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=("${(@)POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS:#command_execution_time}") # Remove the 'command_execution_time' prompt segment.

__source_if_exists ~/.fzf.zsh

# fd is faster when searching with fzf (useful in vim with the fzf plugin and :Files command)
export FZF_DEFAULT_COMMAND='fd --type f --hidden'

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

export GOPATH="${HOME}/src/go"
export PATH="${PATH}:${GOPATH}/bin"

# Don't cd to a directory automatically
unsetopt autocd

export HOMEBREW_NO_ANALYTICS=true

# https://github.com/sp-ricard-valverde/github-act-cache-server
export ACT_CACHE_AUTH_KEY=helloworld

# Create a Powerlevel10k prompt segment that shows that value of $VAULT_ADDR if set.
function prompt_my_vault_addr() {
  if [[ -n $VAULT_ADDR ]]; then
    p10k segment -i 'LOCK_ICON' -r -f black -b cyan -t "$VAULT_ADDR"
  fi
}
# Add it to the right prompt.
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS+=my_vault_addr
# Only show it when running 'vault'.
typeset -g POWERLEVEL9K_MY_VAULT_ADDR_SHOW_ON_COMMAND='vault'

# Prevent duplicate entries from beting added to PATH. Must be at the end of zshrc.
typeset -U path
