if exists('g:loaded_trim_ws')
    finish
endif
let g:loaded_trim_ws = 1

" Remove trailing whitespace on save
function! SetTrim(trim, print)
    let b:trim_ws = a:trim

    if a:trim
        augroup trimws
            autocmd!
            autocmd BufWritePre * :norm mt
            autocmd BufWritePre * :%s/\s\+$//ge
            autocmd BufWritePost * :norm g`t
        augroup END
    else
        try
            autocmd! trimws
            augroup! trimws
        catch
        endtry
    end

    if a:print && a:trim
        echom 'Trim WS on'
    elseif a:print && !a:trim
        echom 'Trim WS off'
    endif
endfunction

" Check if file already has trailing whitespace
function! InitTrimWS()
    " Remember choice
    if exists('b:trim_ws')
        return b:trim_ws
    endif

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

nnoremap <leader>tw :call SetTrim(!b:trim_ws, 1)<CR>

autocmd BufReadPost * call SetTrim(InitTrimWS(), 0)
autocmd BufNewFile * call SetTrim(1, 0)
