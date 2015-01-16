require 'rake'

desc "Display usage"
task :default do
  system("rake -T")
  puts
  puts "This script will setup all the things to make this house a home."
  puts
end

desc "Install all the things"
task :install => ["setup_homebrew", "setup_zsh", "setup_vundle"] do
  puts
  puts "All done!"
  puts
end

private
def run(cmd)
  puts "[RUNNING] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end
private
def info(text)
  puts "[INFO] #{text}"
end

desc "Install Homebrew"
task :setup_homebrew do
  run %{which brew}
  unless $?.success?
    puts "======================================================"
    puts "Installing Homebrew, the OSX package manager...If it's"
    puts "already installed, this will do nothing."
    puts "======================================================"
    run %{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
    puts
    puts
    puts "======================================================"
    puts "Updating Homebrew"
    puts "======================================================"
    run %{brew update}
    puts
    puts
    puts "======================================================"
    puts "Installing Homebrew packages"
    puts "======================================================"
    run %{brew install zsh git hub}
    puts
    puts
  end
end

desc "Install Oh-My-Zsh and switch to ZSH"
task :setup_zsh do
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    info "Looks like oh-my-zsh is already installed: skipping"
  else
    print "install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      info "installing oh-my-zsh"
      run %Q{curl -L http://install.ohmyz.sh | sh}
    when 'q'
      exit
    else
      info "skipping oh-my-zsh"
    end
  end
end

desc "Install Vundle for VIM and activate plugins"
task :setup_vundle do
  if File.exist?(File.join(ENV['HOME'], ".vim/bundle/Vundle.vim"))
    info "Looks like Vundle is already installed: skipping"
  else
    print "install Vundle? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      info "Installing Vundle"
      run %Q{git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle}
      info "Activating Vundle plugins"
      run %Q{vim +PluginInstall +qall}
    when 'q'
      exit
    else
      info "skipping Vundle"
    end
  end
end

