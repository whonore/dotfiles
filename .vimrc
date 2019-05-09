set nocompatible
execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype plugin indent on
colorscheme cobalt

let mapleader = ","

" Indentation Settings
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smarttab
set smartindent

" Misc Settings
set number
set showmode
set ruler
set cursorline
set lazyredraw
set showmatch
set showcmd
set wildmode=longest,list
set visualbell
set encoding=utf-8

" Search Settings
set incsearch
set hlsearch
set smartcase
set wrapscan
nnoremap <leader><space> :nohlsearch<CR>

" Line Length Settings
" Uses autocmd to override plugins that might try to set textwidth
set nowrap
autocmd FileType * setlocal textwidth=0

let s:over = 0
let s:over_pattern = '\%80v.\+'
hi OverLong ctermfg=NONE ctermbg=NONE
function! s:toggleOver()
  let s:over = !s:over
  if s:over
    hi OverLong ctermfg=NONE ctermbg=208
    echom "Check over on"
  else
    hi clear OverLong
    echom "Check over off"
  endif
endfunction
execute 'match OverLong /' . s:over_pattern . '/'
nnoremap <leader>oo :call <SID>toggleOver()<CR>
execute "nnoremap <leader>fo :call search('" . s:over_pattern . "')<CR>"

" Other Misc Settings
set mouse=a
set history=1000
set backspace=2

" Allow hex and binary (if available) formats
set nrformats=hex
if v:version > 704 || v:version == 704 && has('patch1027')
  set nrformats+=bin
endif

" Add system clipboard
set clipboard=unnamedplus,autoselect

" Make Y behave like D, C, etc
map Y y$

" Toggle spell check
nnoremap <leader>ss :setlocal spell!<CR>

" Disable arrow keys
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Assume .tex files are LaTex
let g:tex_flavor = "latex"

" Make :grep use 'git grep'
set grepprg=git\ --no-pager\ grep\ -n\ --column\ --no-color
set grepformat=%f:%l:%c:%m
nnoremap gr :grep <cword><CR>
