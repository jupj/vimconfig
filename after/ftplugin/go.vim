" <F5> will save and "go run" the file
nnoremap <buffer> <F5> :w<cr>:GoRun<cr>

" Add leader shortcuts
nnoremap <buffer> <leader>b :w<cr>:GoBuild<cr>
nnoremap <buffer> <leader>d :w<cr>:GoDoc<cr>
nnoremap <buffer> <leader>r :w<cr>:GoRun<cr>
nnoremap <buffer> <leader>t :w<cr>:GoTest<cr>

" Find definition (allow remapping so that vim-go can do it's magic)
nmap <c-right> gd
" Go back from definition (allow remapping so that vim-go can do it's magic)
nmap <c-left> <c-t>
