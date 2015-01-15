dotfiles
========

I use [Homesick](https://github.com/technicalpickles/homesick) to manage my dotfiles.

### To manually get just the dotfiles:
1. Install Homesick with `gem install homesick`
2. Clone this castle with `homesick clone natemccurdy/dotfiles`
3. Create the symlinks with `homesick symlink dotfiles`

### To automatically setup my enviornment (e.g. on a new computer (OSX)):
1. Make sure the xcode command line tools are installed:
  `xcode-select --install`
2. Run the installer script straight from the web:
  `sh -c "`curl -fsSL https://raw.githubusercontent.com/natemccurdy/dotfiles/master/install.sh`"

### To setup vim-airline fonts:
1. Clone the pre-patched powerline fonts and install them:
  1. `git clone git@github.com:powerline/fonts.git`
  2. `cd fonts; ./install.sh`
2. After install, set your iTerm profile preferences to have __both__ text
   fonts be a 'powerline' enabled font.
