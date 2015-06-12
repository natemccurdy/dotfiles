" Vundle requirements
set nocompatible
filetype off

" Setup Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" GitHub plugins
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/CycleColor'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'bling/vim-airline'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'rodjek/vim-puppet'
Plugin 'puppetlabs/pltraining-userprefs', {'rtp': 'files/vim/vim'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

:so ~/.vimrc.settings
