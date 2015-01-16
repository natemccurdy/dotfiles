require 'rake'
require 'colored'

#================================
# Some helper functions
#================================
private
def info(text)
  puts "[INFO] #{text}".green
end
private
def error(text)
  puts "[ERROR] #{text}".red
end
private
def run(cmd)
  puts "[RUNNING] #{cmd}".yellow
  #`#{cmd}` unless ENV['DEBUG']
  IO.popen("#{cmd}") { |f| puts f.gets }
end
#================================
# End of helper functions
#================================

desc "Display usage"
task :default do
  system("rake -T")
  puts
  info "This script will setup all the things to make this house a home."
  puts
end

desc "Install all the things"
task :install => ["setup_homebrew", "setup_homebrew_native", "setup_zsh",
                  "setup_vundle"] do
  puts
  info "======================================================"
  info "                    WE ARE DONE!"
  info ""
  info " To update things in the future:"
  info "   $ homesick cd dotfiles"
  info "   $ bundle install; rake install"
  info "   $ exit"
  info "======================================================"
  puts
end


desc "Install Homebrew"
task :setup_homebrew do
  info "======================================================"
  info "Installing Homebrew, the OSX package manager...If it's"
  info "already installed, this will do nothing."
  info "======================================================"
  run %{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
  puts
  puts
  info "Installing brew-cask"
  run %{brew install caskroom/cask/brew-cask}
  puts
  info "Updating Homebrew"
  run %{brew update}
  run %{brew upgrade}
  puts
  puts
  info "======================================================"
  info "Installing Homebrew command line tools"
  info "======================================================"
  run %{brew install coreutils moreutils findutils}
  run %{brew install gnu-sed --with-default-names}
  run %{brew install wget --with-iri}
  run %{brew install autoconf automake}
  run %{brew install vim --with-python --override-system-vi}
  run %{brew install homebrew/dupes/grep homebrew/dupes/screen}
  run %{brew install git ack tree xz nmap speedtest_cli cowsay}
  run %{brew install hub ssh-copy-id}
  puts
  puts
  puts
  info "======================================================"
  info "Cleaning up Homebrew"
  info "======================================================"
  run %{brew cleanup}
  puts
end

desc "Install Homebrew OSX Native Apps"
task :setup_homebrew_native do
  print "Would you like to install Homebrew OSX Native Apps? [ynq] "
  case $stdin.gets.chomp
  when 'y'
    puts
    info "======================================================"
    info "Installing Homebrew OSX Native Apps"
    info "======================================================"
    puts
    info "===================== Tools =========================="
    run %{brew cask install box-sync}
    run %{brew cask install iterm2}
    run %{brew cask install lastpass-universal}
    run %{brew cask install the-unarchiver}
    run %{brew cask install vlc}
    puts
    info "===================== Browsers ======================="
    run %{brew cask install google-chrome}
    puts
    info "===================== Virtual Machines ==============="
    run %{brew cask install virtualbox}
    run %{brew cask install vagrant}
    puts
  else
    info "Skipping native Homebrew apps"
  end
end

desc "Install Oh-My-Zsh and switch to ZSH"
task :setup_zsh do
  puts
  info "======================================================"
  info "Installing Oh-My-Zsh"
  info "======================================================"
  puts
  print "install oh-my-zsh? [ynq] "
  case $stdin.gets.chomp
  when 'y'
    info "Doing a manual install of ZSH"
    run %Q{git clone -f git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh}
    run %Q{[[ $SHELL =~ zsh ]] || chsh -s /bin/zsh}
    info "Redo the Homesick symlinks just in case something changes."
    run %Q{homesick symlink dotfiles}
  when 'q'
    exit
  else
    info "skipping oh-my-zsh"
  end
end

desc "Install Vundle for VIM and activate plugins"
task :setup_vundle do
  puts
  info "======================================================"
  info "Installing Vundle"
  info "======================================================"
  puts
  print "install Vundle? [ynq] "
  case $stdin.gets.chomp
  when 'y'
    info "Installing Vundle"
    run %Q{git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim}
    info "Activating Vundle plugins -- THIS MIGHT TAKE A LONG TIME"
    run %Q{vim +PluginInstall +qall}
  when 'q'
    exit
  else
    info "skipping Vundle"
  end
end

