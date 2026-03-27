#!/usr/bin/env sh
# Configure iterm to read preferences out of my dotfiles.
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${HOME}/.local/share/chezmoi/iterm_prefs"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
