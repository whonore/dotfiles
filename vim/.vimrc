let s:vimhomes = [expand('$HOME/.vim'), expand('$HOME/vimfiles'), '']
for s:vimhome in s:vimhomes
  if isdirectory(s:vimhome)
    break
  endif
endfor
if s:vimhome ==# ''
  echoerr printf('Aborting: None of %s exists.', join(s:vimhomes[:-2], ' '))
  finish
endif
if index(split(&runtimepath, ','), s:vimhome) == -1
  let &runtimepath .= ',' . s:vimhome
endif
let s:vimhome .= '/'

" Autoinstall vim-plug
if empty(glob(s:vimhome . 'autoload/plug.vim'))
  execute printf(
    \ 'silent !curl -fLo %sautoload/plug.vim --create-dirs %s',
    \ s:vimhome,
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  if v:shell_error != 0
    echoerr printf('Aborting: failed to download plug.vim (error=%d)', v:shell_error)
    finish
  endif
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
Plug 'editorconfig/editorconfig-vim'
Plug 'joom/latex-unicoder.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'whonore/vim-sentencer'
Plug 'whonore/vim-trim-ws'
" Languages
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'
Plug 'dense-analysis/ale'
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
Plug 'tweekmonster/helpful.vim'
Plug 'whonore/vim-synsational'
Plug 'whonore/vim-unsource'
" Snippets
Plug 'honza/vim-snippets'
if has('python3')
  Plug 'sirver/ultisnips'
endif
Plug 'whonore/coq-ultisnips'
" Misc
Plug 'lambdalisue/suda.vim'
Plug 'whonore/vim-palit'
Plug 'whonore/vim-tictactoe'
call plug#end()

silent! call unsource#unsource(['/etc/vimrc.local'])

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
set softtabstop=-1
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
set conceallevel=2
set nofoldenable

" Search Settings
set incsearch
set hlsearch
set smartcase
set wrapscan
nnoremap <leader><space> :nohlsearch<CR>

" Backups
let s:vimdir = s:vimhome . 'dirs/'
let &directory = s:vimdir . 'tmp'
let &backupdir = s:vimdir . 'back'
let &undodir = s:vimdir . 'undo'
if has('nvim')
  let &shada .= ',n' . s:vimdir . 'shada'
elseif &viminfo !=# ''
  let &viminfo .= ',n' . s:vimdir . 'viminfo'
endif
set backup
set undofile
for s:dir in ['tmp', 'back', 'undo']
  if !isdirectory(s:vimdir . s:dir)
    call mkdir(s:vimdir . s:dir, 'p')
  endif
endfor

" Update spellfiles
let s:spls = glob(s:vimhome . 'spell/*.add', 1, 1)
for s:spl in s:spls
  if filereadable(s:spl)
    \ && (!filereadable(s:spl . '.spl') || getftime(s:spl) > getftime(s:spl . '.spl'))
    execute 'mkspell! ' . fnameescape(s:spl)
  endif
endfor
let &spellfile = join(map(s:spls, 'fnameescape(v:val)'), ',')

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

let s:over = -1
function! s:textwidth() abort
  return &l:textwidth > 0 ? &l:textwidth : get(b:, 'textwidth', 80)
endfunction
function! s:overPattern() abort
  return printf('\%%>%dv.\+$', s:textwidth())
endfunction
function! s:toggleOver() abort
  if s:over == -1
    let s:over = matchadd('ColorColumn', s:overPattern())
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

" ale
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 0
let g:ale_disable_lsp = 1
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_open_list = 1
nnoremap QQ :ALELint<CR>
nnoremap QF :ALEFix<SPACE>

let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

if fnamemodify(&shell, ':p:t') ==# 'fish'
  let g:ale_vim_vint_executable = expand('$HOME/.dotfiles/scripts/vint.fish')
endif

" coqtail
let g:coqtail_match_shift = 1
let g:coqtail_project_names = ['_CoqProject', '_CoqProject.local']
let g:coqtail_auto_set_proof_diffs = 'on'

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" editorconfig
let g:EditorConfig_max_line_indicator = 'exceeding'
let g:EditorConfig_preserve_formatoptions = 1

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

" sentencer
let g:sentencer_textwidth = s:textwidth()
nnoremap <leader>sb :SentencerBind<CR>

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
