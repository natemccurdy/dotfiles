# My dotfiles repo

I use [Homesick](https://github.com/technicalpickles/homesick) to manage my dotfiles.

## Installation

### Homebrew

1. `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
1. Use a better vim: `brew install vim --with-override-system-vi`
1. Install iterm2 nightly: `brew tap caskroom/versions && brew cask install iterm2-nightly`
1. Other tools: `brew install git tmux thefuck the_silver_searcher ripgrep tree nmap xz wget`
1. Use brew's Ruby: `brew install ruby ruby-build`

### Zsh

1. oh-my-zsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
1. `mkdir ~/src`
1. `git clone https://github.com/bhilburn/powerlevel9k.git ~/src/powerlevel9k`

### Homesick

1. Install Homesick with `gem install homesick`
1. Clone this castle with `homesick clone natemccurdy/dotfiles`
1. Create the symlinks with `homesick symlink dotfiles`

### Vim plugins

1. Vundle Install: `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
1. Install Vim plugins: `vim +PluginInstall +qall`
1. Setup YouCompleteMe:
    1. `brew install cmake`
    1. `~/.vim/bundle/YouCompleteMe/install.py`

### iTerm 2

1. Install iterm2 nightly: `brew tap caskroom/versions && brew cask install iterm2-nightly`

#### Colors

I use the GruvBox color scheme for iterm2. Grab a copy of it here, double-click it, then set that as your profile's color scheme.

<https://github.com/morhetz/gruvbox-contrib/raw/master/iterm2/gruvbox-dark.itermcolors>

#### Fonts

Install the Awesome patched fonts.

1. Download and install an Awesome patched font:
    * <https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf>
1. Switch iTerm2 to use that font for **Non ASCII Font**:

![](screenshots/iterm_text_options.png)

