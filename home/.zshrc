# Set my default user so that the ZSH theme doesn't show the hostname.
DEFAULT_USER='nate'

export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME='powerlevel9k'
# PowerLevel9K options
POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_VCS_GIT_ICON=''

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git osx ruby rbenv gem vagrant ssh-agent tmux zsh-syntax-highlighting docker docker-compose)

# Load SSH identities
zstyle :omz:plugins:ssh-agent identities id_rsa gitlab_personal gitlab_work github_personal github_work

# Load HomeBrew autocompletions
fpath=(/usr/local/Homebrew/completions/zsh $fpath)

# Start oh-my-zsh
source $ZSH/oh-my-zsh.sh

# PATH modifications. Don't modify if we're in TMUX because path_helper does it for us.
# I also modifed /etc/zprofile as shown here https://pgib.me/blog/2013/10/11/macosx-tmux-zsh-rbenv/
if [[ -z $TMUX ]]; then

  # Add ~/.bin to PATH
  export PATH="$PATH:$HOME/.bin"
  # Add homebrew's sbin dir to PATH
  export PATH="/usr/local/sbin:$PATH"

  # Initialize rbenv
  if which rbenv >/dev/null ; then
    [[ $PATH =~ 'rbenv/shims' ]] || eval "$(rbenv init -)"
  fi
fi

## Setup envpuppet
## Disabled because I want the native package on my mac to automate my mac.
## This should only be used for testing in vm's and such.
#export ENVPUPPET_BASEDIR="${HOME}/src/puppetlabs"
#eval $($ENVPUPPET_BASEDIR/puppet/ext/envpuppet)

# Source my external alias config
# NOTE about 'ls': If coreutils is installed, oh-my-zsh will alias ls to gls, but
#                  something about it is broken which breaks ls. not sure...
source $HOME/.aliases

