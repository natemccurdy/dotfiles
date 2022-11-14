" PolyGot Settings
" For some reason polyglot requires this before loading the plugin :'(
"let g:polyglot_disabled = ['puppet', 'python', 'python-indent', 'python-compiler']
let g:polyglot_disabled = ['puppet', 'python-indent']

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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'rodjek/vim-puppet'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'

call plug#end()

:so ~/.vimrc.settings
