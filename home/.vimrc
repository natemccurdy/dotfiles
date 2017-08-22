" Vim Plug start
call plug#begin('~/.vim/plugged')

" GitHub plugins
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'dearrrfish/vim-applescript'
Plug 'gabrielelana/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'morhetz/gruvbox'
Plug 'PProvost/vim-ps1'
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe'
Plug 'rodjek/vim-puppet'
Plug 'w0rp/ale'

call plug#end()

:so ~/.vimrc.settings
