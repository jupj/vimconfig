" <F5> will save and run the file
nnoremap <buffer> <F5> :w<CR>:!powershell -File "%:p"<CR>
inoremap <buffer> <F5> <ESC>:w<CR>:!powershell "%:p"<CR>
