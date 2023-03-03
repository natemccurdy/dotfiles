#!/usr/bin/env zsh
#
# Run this on a stock Mac to bootstrap it with Nate's dotfiles and customizations
#
set -euo pipefail

# Ask for the administrator password upfront
echo "Asking for your sudo password upfront..."
sudo -v

# Keep-alive: update existing `sudo` time stamp until this has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install homebrew and git (xcode tools)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor

# Create our code directory
[[ -d ~/src ]] || mkdir ~/src

# Grab Tmux Plugin Manager
mkdir -p ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Get Homesick for dotfiles
sudo gem install homesick --no-doc
homesick clone natemccurdy/dotfiles
homesick symlink dotfiles

# Install HomeBrew apps
brew bundle --file=~/.homesick/repos/dotfiles/Brewfile

# Pin Ruby versions so I don't lose all my gems on upgrade.
brew pin rbenv
rbenv install $(cat ~/.rbenv/version)

# Install some Puppet and ruby tools
~/.rbenv/versions/$(cat ~/.rbenv/version)/bin/gem install r10k puppet-lint rubocop tmuxinator

# Install vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Get Vim plugins
vim +PlugInstall +qall

# Install Oh My ZSH
# This assumes a new MacOS that's using zsh be default, not bash.
export CHSH=no
export RUNZSH=no
export KEEP_ZSHRC=yes
CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Grab PowerLevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k


# Configure iterm to read preferences out of my dotfiles.
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${HOME}/.homesick/repos/dotfiles/iterm_prefs"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Get iTerm gruvbox colors
echo "Installing GruvBox colors for iTerm2"
wget https://github.com/morhetz/gruvbox-contrib/raw/master/iterm2/gruvbox-dark.itermcolors
open gruvbox-dark.itermcolors
rm gruvbox-dark.itermcolors

# Run OSX config script
echo "Configuring a bunch of OSX things"
sh ~/.homesick/repos/dotfiles/home/.bin/osx.sh

echo
echo "Finished!"
echo
echo "All that's left is to configure iTerm2: https://github.com/natemccurdy/dotfiles#colors-and-fonts"
echo
read -r -p "Also, you should reboot. Do that now? [Y/n]: " answer
if [[ $answer =~ ^[Yy]$ ]]; then
  sudo reboot
fi

