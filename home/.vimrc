" Vundle requirements
set nocompatible
filetype off

" Setup Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" GitHub plugins
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'dearrrfish/vim-applescript'
Plugin 'gabrielelana/vim-markdown'
Plugin 'godlygeek/tabular'
Plugin 'morhetz/gruvbox'
Plugin 'PProvost/vim-ps1'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'voxpupuli/vim-puppet'
Plugin 'w0rp/ale'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

:so ~/.vimrc.settings
