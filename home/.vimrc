" Vim Plug start
call plug#begin('~/.vim/plugged')

" GitHub plugins
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'godlygeek/tabular'
Plug 'morhetz/gruvbox'
Plug 'rodjek/vim-puppet'
Plug 'tpope/vim-fugitive'
Plug 'Valloric/ListToggle'
Plug 'w0rp/ale'

call plug#end()

:so ~/.vimrc.settings
