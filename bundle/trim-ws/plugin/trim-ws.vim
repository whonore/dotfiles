if exists('g:loaded_trim_ws')
    finish
endif
let g:loaded_trim_ws = 1

" Remember option and print new value
function! SetTrim(trim, print)
    let b:trim_ws = a:trim

    if a:print && a:trim
        echom 'Trim WS on'
    elseif a:print && !a:trim
        echom 'Trim WS off'
    endif
endfunction

" Toggle trim_ws between true and false
function! ToggleTrim()
    if exists('b:trim_ws')
        call SetTrim(!b:trim_ws, 1)
    else
        " Turn it off if it hasn't been set yet
        call SetTrim(0, 1)
    endif
endfunction

" Check if file already has trailing whitespace
function! InitTrimWS()
    " For completion
    function! YesNo(ArgLead, CmdLine, CursorPos)
        return "Yes\nNo\nyes\nno"
    endfunction

    " Ask if want to keep whitespace
    if search('\s\+$', 'n')
        return input('File has trailing whitespace. Keep it? (y/n): ',
                    \'',
                    \'custom,YesNo') =~? '^n'
    endif

    return 1
endfunction

" Remove trailing whitespace
function! DoTrim()
    if !exists('b:trim_ws')
        let b:trim_ws = InitTrimWS()
    endif

    if b:trim_ws
        norm mt
        %s/\s\+$//ge
        norm g`t
    endif
endfunction

nnoremap <leader>tw :call ToggleTrim()<CR>

autocmd BufWritePre * call DoTrim()
autocmd BufNewFile * call SetTrim(1, 0)
