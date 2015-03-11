# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
DEFAULT_USER='nate'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git osx ruby brew gem vagrant ssh-agent)

# Load SSH identities
zstyle :omz:plugins:ssh-agent identities id_rsa gitlab_personal

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Source my external alias config
source $HOME/.aliases

## Fix $PATH for homebrew
homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH

## Initialize rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

## Add PE bins to $PATH
puppet=/opt/puppet/bin
export PATH=$PATH:$puppet

## Setup envpuppet
## Disabled because I want the native package on my mac to automate my mac.
## This should only be used for testing in vm's and such.
#export ENVPUPPET_BASEDIR="${HOME}/src/puppetlabs"
#eval $($ENVPUPPET_BASEDIR/puppet/ext/envpuppet)

