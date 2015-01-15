#!/usr/bin/env bash

#===================================================
# Some helper functions. Please ignore.
#   credit: https://github.com/atomantic/dotfiles
#===================================================
# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
function ok() {
    echo -e "$COL_GREEN[ok]$COL_RESET "$1
}
function bot() {
    echo -e "\n$COL_GREEN\[._.]/$COL_RESET - "$1
}
function error() {
    echo -e "$COL_RED[error]$COL_RESET "$1
}
#===================================================
# End of helper functions. Carry on.
#===================================================


# Ask for the administrator password upfront
bot "I need you to enter your sudo password so I can install some things:"
sudo -v; ok

# Keep-alive: update existing `sudo` time stamp until this has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Update OSX's RubyGems
bot "Updating OSX's RubyGems before doing anything else..."
sudo gem update --system

# Setup Homesick and pull down the dotfiles repo
# so that we have access to the Rakefile.
castle="natemccurdy/dotfiles"
sudo gem install homesick
if ! which homesick >/dev/null 2>&1; then
    error "Uh oh, it looks like Homesick didn't install."
    exit 1
fi
if [[ $(homesick list) =~ $castle ]]; then
    bot "$castle already exists. Probably already installed"
    bot  "Let's just update it then..."
    homesick pull dotfiles
    homesick symlink dotfiles
else
    bot "Pulling down $castle..."
    homesick clone $castle
    bot "Symlinking $castle..."
    homesick symlink dotfiles
fi

# Run the Rakefile from here on out.
rakefile="$(homesick show_path dotfiles)/Rakefile"
if [[ -f $rakefile ]]; then
    bot "Awesome, good to go. Let's run the Rakefile now..."
    cd $(homesick show_path)
    rake install
else
    error "Can't find the Rakefile at $rakefile"
    exit 1
fi

# Setup HomeBrew
#   - Install brews and casks and stuff.
# Install Dependencies using brew and others.
#   - What are they???
# Run config tasks
#
