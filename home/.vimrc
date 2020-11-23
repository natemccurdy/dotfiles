" Vim Plug start
call plug#begin('~/.vim/plugged')

" GitHub plugins
Plug 'Valloric/ListToggle'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'chr4/nginx.vim'
Plug 'dense-analysis/ale'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'morhetz/gruvbox'
Plug 'rodjek/vim-puppet'
Plug 'tpope/vim-fugitive'

call plug#end()

:so ~/.vimrc.settings
