" Use Vi IMproved
set nocompatible

" Indentation options
set tabstop=2             " Tab width
set shiftwidth=2          " Programmatic indentation width
set expandtab             " Insert spaces instead of tabs
" vim-sleuth overrides theses defaults based on the current file
set autoindent            " Copy indentation from previous line
filetype plugin indent on " Filetype specific indentation

" Gutter
set number         " Show line number
set relativenumber " Show relative line numbers

" Statusline
set laststatus=2 " Always show the status line (vim-airline)

" Syntax highlighting
syntax on

" Search
set hlsearch  " Highlight on search
set incsearch " Search in real time

" Set default encoding to utf-8
set encoding=utf-8

" Allow mutliple unsaved buffers
set hidden

" NERDTree plugin
" Open NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1 " Show hidden files in NERDTree

" ctrlp plugin
let g:ctrlp_show_hidden=1 " Show hidden files in Ctrlp
