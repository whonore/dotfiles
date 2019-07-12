hi clear

if exists("syntax_on")
    syntax reset
endif

set t_Co=256
let g:colors_name = "cobalt"

" Cursor/Visual
hi Cursor	ctermfg=15	ctermbg=NONE	cterm=NONE
hi CursorLine	ctermfg=NONE	ctermbg=23	cterm=NONE
" hi CursorIM
" hi CursorColumn
" hi Visual
" hi VisualNOS

" Diff
" hi DiffAdd
" hi DiffChange
" hi DiffDelete
" hi DiffText

" Search
hi IncSearch	ctermfg=15	ctermbg=36	cterm=NONE
hi Search	ctermfg=15	ctermbg=36	cterm=NONE

" Misc
" hi ColorColumn
" hi Conceal
" hi Directory
" hi Pmenu
" hi PmenuSel
" hi PmenuSbar
" hi PmenuThumb
" hi Question
" hi Folded
" hi FoldColumn
" hi SignColumn
" hi NonText
" hi SpecialKey
" hi Title
" hi WildMenu

" Messages
hi ErrorMsg	ctermfg=15	ctermbg=88	cterm=bold
hi WarningMsg	ctermfg=15	ctermbg=197	cterm=NONE
" hi ModeMsg
" hi MoreMsg

" Lines/Split
hi LineNr	ctermfg=25	ctermbg=232	cterm=NONE
hi MatchParen	ctermfg=NONE	ctermbg=68	cterm=NONE
" hi CursorLineNr
" hi EndOfBuffer
" hi VertSplit
" hi StatusLine
" hi StatusLineNC
" hi TabLine
" hi TabLineFill
" hi TabLineSel

" Spelling
hi SpellBad	ctermfg=9	ctermbg=11	cterm=underline
" hi SpellCap
hi SpellLocal	ctermfg=14	ctermbg=11	cterm=underline
" hi SpellRare

" Links
hi! link EndOfBuffer	LineNr

" Programming
hi Normal	ctermfg=15	ctermbg=233	cterm=NONE
hi Boolean	ctermfg=197	ctermbg=NONE	cterm=NONE
hi Comment	ctermfg=33	ctermbg=NONE	cterm=NONE
" hi Debug
hi Define	ctermfg=121	ctermbg=NONE	cterm=bold
" hi Exception
hi Identifier	ctermfg=252	ctermbg=NONE	cterm=NONE
" hi Ignore
" hi Include
hi Keyword	ctermfg=214	ctermbg=NONE	cterm=bold
" hi Label
" hi Macro
hi Number	ctermfg=197	ctermbg=NONE	cterm=NONE
hi Operator	ctermfg=214	ctermbg=NONE	cterm=NONE
" hi PreConduit
" hi Special	ctermfg=222	ctermbg=NONE	cterm=NONE
hi SpecialChar	ctermfg=222	ctermbg=NONE	cterm=NONE
" hi SpecialComment
" hi StorageClass
hi String	ctermfg=76	ctermbg=NONE	cterm=NONE
" hi Structure
" hi Tag
hi Todo		ctermfg=33	ctermbg=NONE	cterm=reverse
hi Type		ctermfg=121	ctermbg=NONE	cterm=NONE
" hi Typedef
" hi Underlined

" Links
hi! link Character	String
hi! link Conditional	Statement
hi! link Constant	Define
hi! link Delimiter	Operator
hi! link Float		Number
hi! link Function	Identifier
hi! link PreProc	Define
hi! link Repeat		Statement
hi! link Statement	Keyword
