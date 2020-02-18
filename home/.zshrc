export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME='powerlevel9k'

# PowerLevel9K options
DEFAULT_USER=$USER
POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv background_jobs)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''
POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=''
POWERLEVEL9K_HIDE_BRANCH_ICON=true

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git osx ruby gem vagrant ssh-agent docker docker-compose)

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
  export PATH="$PATH:$HOME/.bin"
  # Add homebrew's sbin dir to PATH
  export PATH="/usr/local/sbin:$PATH"

fi

# Initialize rbenv
# I modifed /etc/zprofile as shown here https://pgib.me/blog/2013/10/11/macosx-tmux-zsh-rbenv/
# to prevent rbenv from ending up at the end of PATH.
if type rbenv >/dev/null ; then
  if [[ $PATH =~ 'rbenv/shims' ]]; then
    eval "$(rbenv init - | sed '/PATH/d')" # Prevent rbenv ending up in PATH twice.
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

if [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

export EDITOR='nvim'

# Used for various git aliases
export REVIEW_BASE='master'

if [[ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]]; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi
