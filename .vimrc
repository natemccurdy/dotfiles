" =============================================================================
"  Initialization
" =============================================================================

" Start Pathogen
execute pathogen#infect()

" Use Vim settings instead of Vi settings.
set nocompatible

" If vimrc has been modified, re-source it for fast modifications
autocmd! BufWritePost *vimrc source %

" =============================================================================
"  Filetype Association
" =============================================================================

au BufRead,BufNewFile *vimrc
\ set foldmethod=marker
augroup Puppet
    autocmd! BufEnter *.pp set filetype=puppet
augroup end
augroup RubySyntaxFiles " Ruby syntax
    autocmd! BufRead,BufEnter *.rb,*.rake set tabstop=2 sts=2 shiftwidth=2 filetype=ruby
    autocmd! BufEnter Rakefile set filetype=ruby
    autocmd! BufEnter Gemfile set filetype=ruby
augroup end
augroup MarkdownFiles " Instead of this Modulo file bullshit
    autocmd! BufEnter *.md set filetype=markdown
augroup end
au BufWritePost ~/.bashrc !source %
au BufRead,BufNewFile *_spec.rb
    \ nmap <F8> :!rspec --color %<CR>
augroup PatchDiffHighlight
    autocmd!
    autocmd BufEnter *.patch,*.rej,*.diff syntax enable
augroup end

" =============================================================================
"  Look and Feel
" =============================================================================
" Used for saving git and hg commits
filetype on
filetype off

" Set to allow you to backspace while back past insert mode
set backspace=2

" Disable mouse
set mouse=

" Increase History
set history=100

" Enable relative number in the left column
"set relativenumber

"Enable line numbers
set number

" Give context to where the cursor is positioned in a file
set scrolloff=14

" Use UTF-8 encoding
set encoding=utf-8 nobomb

" Hide buffers after they are abandoned
set hidden

" Disable files that don't need to be created
set noswapfile
set nobackup
set nowritebackup

" Auto Complete Menu
set completeopt=longest,menu

" Enable indentation matching for =>'s
filetype plugin indent on

" Show me a ruler
set ruler

" Tabbing and Spaces
" ------------------

" Use 4 spaces instead of tabs
set ts=4
set sts=4
set shiftwidth=4
set expandtab

" Auto indent
set autoindent
set smartindent

" Color Settings
" --------------

" Enable highlight search and highlight when searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set gdefault

" Enable syntax highlighting
syntax enable

" Highlight column 80
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Highlight Trailing Whitespace
highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue
match ExtraWhitespace /\s\+$/

" Persistent Undo
if v:version >= 703
    set undofile
    set undodir=~/.vim/tmp,~/.tmp,~/tmp,~/var/tmp,/tmp
endif

" Spelling / Typos
:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q

" Open file and goto previous location
autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
    \|     exe "normal! g`\""
    \|  endif
