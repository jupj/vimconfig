" <F5> will save and "go run" the file
nnoremap <buffer> <F5> :up<cr>:GoRun<cr>
inoremap <buffer> <F5> <ESC>:up<CR>:GoRun<CR>

" Add leader shortcuts
nnoremap <buffer> <leader>b :up<cr>:GoBuild<cr>
nnoremap <buffer> <leader>d :up<cr>:GoDoc<cr>
nnoremap <buffer> <leader>dd :up<cr>:GoDocBrowser<cr>
nnoremap <buffer> <leader>r :up<cr>:GoRun<cr>
nnoremap <buffer> <leader>t :up<cr>:GoTest<cr>

" Find definition (allow remapping so that vim-go can do it's magic)
nmap <c-right> gd
" Go back from definition (allow remapping so that vim-go can do it's magic)
nmap <c-left> <c-t>