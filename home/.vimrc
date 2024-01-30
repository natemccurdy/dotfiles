" PolyGot Settings
" For some reason polyglot requires this before loading the plugin :'(
"let g:polyglot_disabled = ['puppet', 'python', 'python-indent', 'python-compiler']
let g:polyglot_disabled = ['puppet']

" Vim Plug start
call plug#begin('~/.vim/plugged')

" GitHub plugins
Plug 'Valloric/ListToggle'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'github/copilot.vim'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'jjo/vim-cue'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'rodjek/vim-puppet'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'

call plug#end()

:so ~/.vimrc.settings
