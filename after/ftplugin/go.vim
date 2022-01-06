" <F5> will save and "go run" the file
nnoremap <buffer> <F5> :up<cr>:term go run .<cr>
inoremap <buffer> <F5> <ESC>:up<CR>:term go run .<CR>

" Add leader shortcuts
nnoremap <buffer> <leader>b :up<cr>:GoBuild<cr>
nnoremap <buffer> <leader>d :up<cr>:GoDoc<cr>
nnoremap <buffer> <leader>dd :up<cr>:GoDocBrowser<cr>
nnoremap <buffer> <leader>r :up<cr>:term go run .<cr>
nnoremap <buffer> <leader>t :up<cr>:GoTest<cr>

" Find definition (allow remapping so that vim-go can do it's magic)
nmap <c-right> gd
" Go back from definition (allow remapping so that vim-go can do it's magic)
nmap <c-left> <c-t>

" Add abbreviations
iabbrev <buffer> perr if err != nil {<cr>panic(err)<cr>}
iabbrev <buffer> rerr <esc>:GoIfErr<cr>O
iabbrev <buffer> terr if err != nil {<cr>t.Fatal(err)<down>
iabbrev <buffer> defc defer.Close()<left><left><left><left><left><left><left><left>

" Set tab settings
setlocal tabstop=4
setlocal noexpandtab
setlocal shiftwidth=4
