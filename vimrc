source $VIM\_vimrc
set nocompatible

call pathogen#infect()
call pathogen#helptags()

" UI customisation:
set guifont=Courier_New:h10:cDEFAULT
colorscheme peaksea
" Format the line numbers:
hi LineNr guifg=Grey
hi LineNr guibg=DarkGrey

" Expand tabs to 4 spaces:
set expandtab
set tabstop=4
set shiftwidth=4

" Disable backup and swap files:
set nobackup
set noswapfile

" Search case-insensitivity unless upper case characters are in the search phrase
set ignorecase
set smartcase
set autoindent " always set autoindenting on
set copyindent " copy the previous indentation on autoindenting
set smarttab   "tab uses shiftwidth instead of tabstop

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

" Disable the error beep:
set noerrorbells
"set visualbell
"set t_vb=

" Map Shift-Space to Esc:
imap <C-Space> <Esc>

" Map CTRL-N to show NERD_tree
nmap <silent> <c-n> :NERDTreeToggle<CR>

set hidden "allow unsaved changes in hidden buffers
filetype plugin indent on " use intending intelligence based on filetype

" Use - instead of : to activate command mode
nnoremap - :
" change the mapleader from \ to ,
let mapleader=","
" ,s = substitute the current word
nnoremap <leader>s yiw:%s/<c-r>"/
" ,c = copy the whole file contents into the clipboard
nnoremap <leader>c :%y*<CR>

" disable arrowkeys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
