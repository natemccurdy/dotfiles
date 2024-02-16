" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" PolyGot Settings
" For some reason polyglot requires this before loading the plugin :'(
"let g:polyglot_disabled = ['puppet', 'python', 'python-indent', 'python-compiler']
let g:polyglot_disabled = ['puppet']

" Vim Plug start
call plug#begin(data_dir.'/plugged')

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
Plug 'preservim/nerdtree'
Plug 'rodjek/vim-puppet'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'

call plug#end()

:so ~/.vimrc.settings
