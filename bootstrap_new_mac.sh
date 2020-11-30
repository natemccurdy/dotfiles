#!/usr/bin/env bash
#
# Run this on a stock Mac to bootstrap it with Nate's dotfiles and customizations
#

# Ask for the administrator password upfront
echo "Asking for your sudo password upfront..."
sudo -v

# Keep-alive: update existing `sudo` time stamp until this has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install homebrew and git (xcode tools)
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# Create our code directory
[[ -d ~/src ]] || mkdir ~/src

# Grab PowerLevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

# Get Homesick for dotfiles
sudo gem install homesick --no-doc --no-ri
homesick clone natemccurdy/dotfiles
homesick symlink dotfiles

# Install HomeBrew apps
brew bundle --file=~/.homesick/repos/dotfiles/Brewfile
brew cask cleanup

# Pin Ruby versions so I don't lose all my gems on upgrade.
brew pin ruby-build
brew pin rbenv

# Install some Puppet and ruby tools
gem install r10k puppet-lint rubocop

# Install vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Get Vim plugins
vim +PlugInstall +qall

# Install Oh My ZSH and change shell to zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
echo "Changing ${USER}'s shell to Brew's zsh..."
sudo dscl . -create "/Users/$USER" UserShell /usr/local/bin/zsh

# Get fonts
echo "Downloading Inconsolata fonts to ~/Library/Fonts/"
wget -P ~/Library/Fonts/ https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf

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

