require 'rake'

desc "Display usage"
task :default do
    system("rake -T")
    puts
    puts "This script will setup all the things to make this house a home."
    puts
end

desc "Install all the things"
task :install => ["setup_zsh"] do
    puts
    puts "All done!"
    puts
end

desc "Install Oh-My-Zsh and switch to ZSH"
task :setup_zsh do
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    puts "Looks like oh-my-zsh is already installed, so let's skip that part."
  else
    print "install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing oh-my-zsh"
      system %Q{curl -L http://install.ohmyz.sh | sh}
    when 'q'
      exit
    else
      puts "skipping oh-my-zsh"
    end
  end
end

