# My dotfiles repo

I use [Homesick](https://github.com/technicalpickles/homesick) to manage my dotfiles.

## (Mostly) Auto bootstrap of a new mac

Change the `COMPUTER_NAME` environment variable to be whatever you want. Or
leave it out to not change the default computer name.

```bash
curl -O https://raw.githubusercontent.com/natemccurdy/dotfiles/master/bootstrap_new_mac.sh \
  && chmod u+x bootstrap_new_mac.sh
COMPUTER_NAME=foo ./bootstrap_new_mac.sh
```

## Manual Installation

### ZSH

1. oh-my-zsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
1. `mkdir ~/src`

I use the [PowerLevel10k](https://github.com/romkatv/powerlevel10k.git) ZSH theme

1. `git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`

### Homesick

1. Install Homesick with `gem install homesick`
1. Clone this castle with `homesick clone natemccurdy/dotfiles`
1. Create the symlinks with `homesick symlink dotfiles`

### Homebrew

I use [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) for most
of my application installations

1. Install HomeBrew: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
1. Install all the brews: `homesick cd && brew bundle`

### NeoVim plugins

1. Open `nvim`
1. lazy.nvim will install all plugins, Mason will install tools.

### Colors and Fonts

GruvBox iTerm2 color scheme. Download it, open it, then set it as your
profile's color scheme:
<https://github.com/morhetz/gruvbox-contrib/raw/master/iterm2/gruvbox-dark.itermcolors>

```bash
wget https://github.com/morhetz/gruvbox-contrib/raw/master/iterm2/gruvbox-dark.itermcolors
open gruvbox-dark.itermcolors
rm gruvbox-dark.itermcolors
```

I use "MesoLGS Nerd Font" from <https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.tar.xz>

```bash
# Install Meslo Nerd Fonts
brew install --cask font-meslo-lg-nerd-font
```

![](screenshots/iterm_text_options.png)

### MacOS Settings and Tweaks

```bash
homesick cd && COMPUTER_NAME=foo ./home/.bin/osx.sh
```

## Other Mac Applications

Here are some apps from the Apple Store that I use all the time. They're on
Homebrew, but I use the App Store versions so that my registration info is
automatically setup.

* Amphetamine: <https://itunes.apple.com/us/app/amphetamine/id937984704?mt=12> or `brew install mas && mas install 937984704`
* Gifox: <https://gifox.io/>
* Moom: <https://manytricks.com/moom/>
* Witch: <https://manytricks.com/witch/>
