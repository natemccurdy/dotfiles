# Set my default user so that the ZSH theme doesn't show the hostname.
DEFAULT_USER='nate'

export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME='powerlevel9k'
# PowerLevel9K options
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHORTEN_STRATEGY='truncate_middle'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git osx ruby brew gem vagrant ssh-agent tmux)

# Load SSH identities
zstyle :omz:plugins:ssh-agent identities id_rsa gitlab_personal gitlab_work github_personal github_work

# Start oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Source my external alias config
source $HOME/.aliases

## Fix $PATH for homebrew
homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH

## Initialize rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

## Setup envpuppet
## Disabled because I want the native package on my mac to automate my mac.
## This should only be used for testing in vm's and such.
#export ENVPUPPET_BASEDIR="${HOME}/src/puppetlabs"
#eval $($ENVPUPPET_BASEDIR/puppet/ext/envpuppet)

