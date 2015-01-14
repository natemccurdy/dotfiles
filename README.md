dotfiles
========

I use [Homesick](https://github.com/technicalpickles/homesick) to manage my dotfiles.

### To get the dotfiles:
1. Install Homesick with `gem install homesick`
2. Clone this castle with `homesick clone natemccurdy/dotfiles`
3. Create the symlinks with `homesick symlink dotfiles`

### To setup my enviornment:
1. `homesick cd dotfiles`
2. `bundle`
3. `rake install`

### To setup vim-airline fonts:
1. Clone the pre-patched powerline fonts and install them:
  1. `git clone git@github.com:powerline/fonts.git`
  2. `cd fonts; ./install.sh`
2. After install, set your iTerm profile preferences to have __both__ text
   fonts be a 'powerline' enabled font.
