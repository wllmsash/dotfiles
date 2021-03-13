" Use Vi IMproved
set nocompatible

" Tab options
" Using vim-sleuth to automate this currently
" set tabstop=4
" set shiftwidth=4
" set expandtab

" Highlight on search
set hlsearch

" Show line numbers and count relative
set number
set relativenumber

" Turn on syntax highlighting on macOS
filetype plugin indent on
syntax on

" Always show vim-airline even on non-splits
set laststatus=2

" Set default encoding to utf-8
set encoding=utf-8

" Binding for NERDTree
map <C-n> :NERDTreeToggle<CR>

" Show hidden files in NERDTree
let NERDTreeShowHidden=1

" Show hidden files in Ctrlp
let g:ctrlp_show_hidden=1
