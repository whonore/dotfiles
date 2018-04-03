if exists('g:loaded_trim_ws')
    finish
endif
let g:loaded_trim_ws = 1

function! DoTrim()
    norm mt
    %s/\s\+$//ge
    norm g`t
endfunction

" Remove trailing whitespace on save
function! SetTrim(trim, print)
    let b:trim_ws = a:trim

    if a:trim
        autocmd BufWritePre <buffer> call DoTrim()
    else
        try
            autocmd! BufWritePre <buffer>
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
