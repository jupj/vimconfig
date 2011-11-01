source $VIM\_vimrc

call pathogen#infect()
call pathogen#helptags()

" JJ's own settings:
set guifont=Courier_New:h10:cDEFAULT
" colorscheme desert
" colorscheme ir_black
colorscheme peaksea
" Format the line numbers:
hi LineNr guifg=Grey
hi LineNr guibg=DarkGrey

" Expand tabs to spaces:
set expandtab
" A tab is 4 spaces wide:
set tabstop=4
" Indent code by 4 spaces:
set shiftwidth=4
" Disable backup files:
set nobackup
set nowritebackup
" Save swap files in the temp folder:
set directory=$TMP

" Search case-insensitivity unless upper case characters are in the search phrase
set ignorecase
set smartcase

" Spell check
function! ToggleSpell()
    if !exists("b:spell")
        setlocal spell spelllang=en_us
        let b:spell = 1
    else
        setlocal nospell
        unlet b:spell
    endif
endfunction
 
" Map the <F4> to spell checking
nmap <F4> :call ToggleSpell()<CR>
imap <F4> <Esc>:call ToggleSpell()<CR>a

" Enable python compiler
autocmd BufNewFile,BufRead *.py compiler python

" Unmap CTRL-A and CTRL-X (added via mswin)
unmap <C-A>
unmap <C-X>

" assume .pas-files are delphi ones:
let pascal_delphi=1

" Show the line numers:
set number

"let g:xml_syntax_folding = 1
"au FileType xml setlocal foldmethod=syntax

" Disable the error beep:
set noerrorbells
"set visualbell
"set t_vb=

" Map Shift-Space to Esc:
imap <C-Space> <Esc>

nmap <silent> <c-n> :NERDTreeToggle<CR>
