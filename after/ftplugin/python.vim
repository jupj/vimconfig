" Do not use tabs for Python
setlocal expandtab

" <F5> will save and run the file
nnoremap <buffer> <F5> :w<CR>:!python3 "%"<CR>
inoremap <buffer> <F5> <ESC>:w<CR>:!python3 "%"<CR>

" <F9> will save and run the file and don't care about output
nnoremap <buffer> <F9> :w<CR>:silent !python3 "%"<CR>

" <F6> will save and lint the file into buffer [pylint_results]
nnoremap <buffer> <F6> :call Pylint()<CR>

function! Pylint()
    " Save current buffer and pylint the buffer. Open the results in a new
    " buffer
    :w
    let l:pyfile = expand("%:p")
    " open pylint buffer in new window
    :vsplit
    :e [pylint_results]
    " Clear buffer
    normal! gg
    normal! dG
    "" Read result from pylint
    execute ':r!pylint "' . l:pyfile . '"'
    " Clean up line-endings
    :%s/\r//
    normal! gg
endfunction
