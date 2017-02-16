set nocompatible
syntax on
filetype plugin indent on
colorscheme cobalt

let mapleader=","

" Indentation Settings
set tabstop=4
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

" Search Settings
set incsearch
set hlsearch
set smartcase
nnoremap <leader><space> :nohlsearch<CR>

" Line Length Settings
" Uses autocmd to override plugins that might try to set textwidth
set nowrap
autocmd FileType * setlocal textwidth=0

let over=0
hi OverLong ctermfg=NONE ctermbg=NONE
function ToggleOver()
    let g:over = !g:over
    if g:over
        hi OverLong ctermfg=NONE ctermbg=208
    else
        hi clear OverLong
    endif
endfunction
match OverLong /\%80v.\+/
nnoremap <leader>oo :call ToggleOver()<CR>

" Other Misc Settings
set mouse=a
set history=1000
set backspace=2

" Allow hex and binary (if available) formats
set nrformats=hex
if v:version > 704 || v:version == 704 && has("patch1027")
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

" Make ctrl-arrows switch between args
nnoremap <C-Left> :previous<CR>
nnoremap <C-Right> :next<CR>
nnoremap <C-Up> :first<CR>
nnoremap <C-Down> :last<CR>

" Remove trailing whitespace on save
autocmd BufWritePre * :@norm mt
autocmd BufWritePre * :%s/\s\+$//ge
autocmd BufWritePost * :@norm `t
