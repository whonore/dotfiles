let s:vimhome = expand('$HOME/.vim/')
if !isdirectory(s:vimhome)
  echoerr printf('Aborting: %s does not exist.', s:vimhome)
  finish
endif

" Autoinstall vim-plug
if empty(glob(s:vimhome . 'autoload/plug.vim'))
  execute printf('silent !curl -fLo %sautoload/plug.vim --create-dirs' .
                \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
                \ s:vimhome)
endif
call plug#begin(s:vimhome . 'bundle')
" Plugins
Plug 'junegunn/vim-plug'
" Display
Plug 'vim-airline/vim-airline'
" Colorschemes
Plug 'whonore/vim-blueper'
" Editing
Plug 'andymass/vim-matchup'
Plug 'joom/latex-unicoder.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'whonore/vim-sentencer'
Plug 'whonore/vim-trim-ws'
" Languages
Plug 'dag/vim-fish'
Plug 'leafgarland/typescript-vim'
Plug 'lervag/vimtex'
Plug 'LnL7/vim-nix'
Plug 'rust-lang/rust.vim'
Plug 'whonore/Coqtail'
Plug 'whonore/deepsea.vim'
Plug 'whonore/vim-kami'
" Navigation
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'whonore/vim-debate'
" Scripting
Plug 'junegunn/vader.vim'
Plug 'whonore/helpful.vim', {'branch': 'buffer_version'} " Fork from tweekmonster
Plug 'whonore/vim-synsational'
" Snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'whonore/coq-ultisnips'
" Misc
Plug 'lambdalisue/suda.vim'
Plug 'whonore/vim-tictactoe'
call plug#end()

syntax on
filetype plugin indent on
try
  colorscheme blueper
  let g:airline_theme = 'blueper'
  let g:Lf_StlColorscheme = 'blueper'
catch /E185:/
  colorscheme cobalt
endtry

let g:mapleader = ','
let g:maplocalleader = g:mapleader

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
set nojoinspaces

" Search Settings
set incsearch
set hlsearch
set smartcase
set wrapscan
nnoremap <leader><space> :nohlsearch<CR>

" Backups
let s:vimdir = s:vimhome . 'dirs/'
execute 'set directory=' . s:vimdir . 'tmp'
execute 'set backupdir=' . s:vimdir . 'back'
execute 'set undodir=' . s:vimdir . 'undo'
if has('nvim')
  execute 'set shada+=n' . s:vimdir . 'shada'
elseif &viminfo !=# ''
  execute 'set viminfo+=n' . s:vimdir . 'viminfo'
endif
set backup
set undofile
for s:dir in ['tmp', 'back', 'undo']
  if !isdirectory(s:vimdir . s:dir)
    call mkdir(s:vimdir . s:dir, 'p')
  endif
endfor

" Update spellfiles
for s:spl in glob(s:vimhome . 'spell/*.add', 1, 1)
    if filereadable(s:spl)
      \ && (!filereadable(s:spl . '.spl') || getftime(s:spl) > getftime(s:spl . '.spl'))
        execute 'mkspell! ' . fnameescape(s:spl)
    endif
    execute 'set spellfile+=' . fnameescape(s:spl)
endfor

" Make * and # work on visual selection
function! s:getSelected() abort
  let l:reg = getreg('"')
  let l:type = getregtype('"')
  normal! gvy
  let l:ret = getreg('"')
  call setreg('"', l:reg, l:type)
  execute "normal \<ESC>"
  return substitute(l:ret, '\_s\+', '\\_s\\+', 'g')
endfunction

vnoremap <silent> * :call setreg("/", <SID>getSelected())<CR>n
vnoremap <silent> # :call setreg("/", <SID>getSelected())<BAR>let v:searchforward = 0<CR>n

" Line Length Settings
" Uses autocmd to override plugins that might try to set textwidth
set nowrap
augroup vimrc
  autocmd! *
  autocmd FileType * setlocal textwidth=0
augroup END

hi def link OverLong WarningMsg
let s:over = -1
let s:over_pattern = '\%%%dv.\+$'
function! s:overPattern() abort
  let l:textwidth = &textwidth > 0 ? &textwidth : 80
  return printf(s:over_pattern, l:textwidth)
endfunction
function! s:toggleOver() abort
  if s:over == -1
    let s:over = matchadd('OverLong', s:overPattern())
  else
    silent! call matchdelete(s:over)
    let s:over = -1
  endif
endfunction
function! s:searchOver(backwards) abort
  call search(s:overPattern(), 'w' . (a:backwards ? 'b' : ''))
endfunction

nnoremap <silent> <leader>oo :call <SID>toggleOver()<CR>
nnoremap <silent> ]o :call <SID>searchOver(0)<CR>
nnoremap <silent> [o :call <SID>searchOver(1)<CR>

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
if has('nvim')
  set clipboard=unnamedplus
elseif has('unnamedplus')
  set clipboard=unnamedplus,autoselectplus
else
  set clipboard=unnamed,autoselect
endif

" Make Y behave like D, C, etc
noremap Y y$

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

" Make :grep use smarter tools
if system('rg --version') !=# ''
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
else
  let s:gitv = split(system('git --version'))
  if s:gitv != []
    let s:gitv = split(s:gitv[2], '\.')
    " If >=2.19 add --column
    if 2 < s:gitv[0] || (2 <= s:gitv[0] && 19 <= s:gitv[1])
      set grepprg=git\ --no-pager\ grep\ -n\ --no-color\ --column
      set grepformat=%f:%l:%c:%m
    else
      set grepprg=git\ --no-pager\ grep\ -n\ --no-color
      set grepformat=%f:%l:%m
    endif
  endif
endif
nnoremap gr :grep <cword><CR>

" File Searching
cabbrev <expr> %% fnameescape(expand('%:p:h'))

" Window resizing
command! -nargs=1 -count=1 Resize :resize <args><count> | :vertical resize <args><count>
nnoremap + :<C-U>execute v:count1 'Resize +'<CR>
nnoremap - :<C-U>execute v:count1 'Resize -'<CR>

" Plugins
" airline
let g:airline#extensions#whitespace#enabled = 0

" coqtail
let g:coqtail_match_shift = 1
let g:coqtail_project_names = ['_CoqProject', '_CoqProject.local']

" fzf
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <leader>f :Files<CR>
let g:fzf_action = {'ctrl-a': 'argadd'}
if v:version >= 800
  let g:fzf_layout = {'window': 'botright split'}
else
  let g:fzf_layout = {'down': '~40%'}
endif

" gutentags
let g:gutentags_file_list_command = 'rg --files'

" helpful
nnoremap <silent> <leader>hh :let b:helpful = !get(b:, 'helpful', 0)<CR>

" matchup
let g:matchup_surround_enabled = 1
let g:matchup_matchparen_offscreen = {}

" synsational
let g:synsational_mode = 'popup'

" trim-ws
let g:trim_ws_verbose = 0

" ultisnips
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<C-J><C-J>'
let g:UltiSnipsJumpForwardTrigger = '<C-F>'
let g:UltiSnipsListSnippets = '<C-J><C-L>'
let g:UltiSnipsNoPythonWarning = 1

" unicoder
imap <C-l> <Plug>Unicoder

" vimtex
let g:tex_flavor = 'latex'
let g:tex_comment_nospell = 1
let g:matchup_override_vimtex = 1
