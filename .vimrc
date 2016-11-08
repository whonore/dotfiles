set nocompatible
syntax on
filetype plugin indent on
colorscheme cobalt

let mapleader=","

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smarttab
set smartindent

set number
set showmode
set ruler
set cursorline
set lazyredraw
set showmatch
set showcmd
set wildmode=longest,list

set incsearch
set hlsearch
set smartcase
nnoremap <leader><space> :nohlsearch<CR>

set nowrap
set textwidth=80

set mouse=a
set history=1000
set backspace=2

set nrformats=hex
if v:version > 703
    set nrformats+=bin
endif

set clipboard=unnamedplus,autoselect

map Y y$

nnoremap <leader>ss :setlocal spell!<CR>

nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

autocmd BufWritePre * :mark t
autocmd BufWritePre * :%s/\s\+$//ge
autocmd BufWritePost * :'t
