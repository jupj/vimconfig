" <F5> creates a pdf out of the markdown file
nnoremap <buffer> <F5> :w<CR>:!pandoc --standalone "%" -o "%:r.pdf"<cr>
set textwidth=80
