# Set my default user so that the agnoster theme doesn't show the hostname.
DEFAULT_USER='nate'

if [[ -f $HOME/.antigen/antigen.zsh ]]; then
    # Source Antigen
    source $HOME/.antigen/antigen.zsh
    # Loaad oh-my-zsh library
    antigen use oh-my-zsh
    # Use some plugins
    antigen bundle git
    antigen bundle osx
    antigen bundle ruby
    antigen bundle brew
    antigen bundle gem
    antigen bundle vagrant
    antigen bundle ssh-agent
    antigen bundle zsh-users/zsh-syntax-highlighting
    # Set the theme
    antigen theme agnoster
    # Compelte the Antigen run
    antigen apply
fi

# Load SSH identities
zstyle :omz:plugins:ssh-agent identities id_rsa gitlab_personal

# Source my external alias config
source $HOME/.aliases

## Fix $PATH for homebrew
homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH

## Initialize rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

## Add PE bins to the end of $PATH
puppet=/opt/puppet/bin
export PATH=$PATH:$puppet

## Setup envpuppet
## Disabled because I want the native package on my mac to automate my mac.
## This should only be used for testing in vm's and such.
#export ENVPUPPET_BASEDIR="${HOME}/src/puppetlabs"
#eval $($ENVPUPPET_BASEDIR/puppet/ext/envpuppet)

