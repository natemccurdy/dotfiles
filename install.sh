#!/usr/bin/env bash

#===================================================
# Some helper functions. Please ignore.
#===================================================
# Colors
ESC="\x1b["
RESET=$ESC"39;49;00m"
RED=$ESC"31;01m"
GREEN=$ESC"32;01m"
function info() {
    echo -e "\n${GREEN}[INFO] ${1}${RESET}"
}
function error() {
    echo -e "\n${RED}[ERROR] ${1}${RESET}"
}
#===================================================
# End of helper functions. Carry on.
#===================================================

# Check that XCode Command Lines Tools are installed
xcode-select -p >/dev/null 2>&1
retval="$?"
if [[ $retval -ne 0 ]]; then
    error "XCode Command Line Tools are not installed"
    error "Install them with 'xcode-select --install' first"
    exit 1
fi

# Ask for the administrator password upfront
info "I need you to enter your sudo password so I can install some things:"
sudo -v

# Keep-alive: update existing `sudo` time stamp until this has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Update OSX's RubyGems
info "Updating OSX's RubyGems before doing anything else..."
sudo gem update --system

# Setup Homesick and pull down the dotfiles repo
# so that we have access to the Rakefile.
castle="natemccurdy/dotfiles"
info "Install Homesick and pull down $castle"
sudo gem install homesick
if ! which homesick >/dev/null 2>&1; then
    error "Uh oh, it looks like Homesick didn't install. Exiting..."
    exit 1
fi
if [[ $(homesick list) =~ $castle ]]; then
    info "$castle already exists. Let's just update it then..."
    homesick pull dotfiles
    homesick symlink dotfiles
else
    info "Pulling down $castle..."
    homesick clone $castle
    info "Symlinking $castle..."
    homesick symlink dotfiles
fi

# Install gems from the Gemfile using bundler.
gemfile="$(homesick show_path dotfiles)/Gemfile"
info "Attempting to install all of our gems now"
if [[ -f $gemfile ]]; then
    info "Gemfile found. Installing Ruby Gems from $gemfile"
    cd $(homesick show_path)
    bundle install
else
    error "Can't find the Gemfile at '${gemfile}'. Exiting..."
    exit 1
fi

# Run the Rakefile from here on out.
rakefile="$(homesick show_path dotfiles)/Rakefile"
info "Attempting to run the Rakefile to continue with the install"
if [[ -f $rakefile ]]; then
    info "Rakefile found. Running $rakefile"
    cd $(homesick show_path)
    rake install
else
    error "Can't find the Rakefile at '${rakefile}'. Exiting..."
    exit 1
fi

