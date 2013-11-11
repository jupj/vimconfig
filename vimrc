source $VIM\_vimrc
set nocompatible

call pathogen#infect()
call pathogen#helptags()

" UI customisation:
set guifont=Courier_New:h10:cDEFAULT
colorscheme mayansmoke

" Expand tabs to 4 spaces:
"set expandtab
"set tabstop=4
set shiftwidth=4
set tabstop=4

" Disable backup and swap files:
set nobackup
set noswapfile

" Search case-insensitivity unless upper case characters are in the search phrase
set ignorecase
set smartcase
set autoindent " always set autoindenting on
set copyindent " copy the previous indentation on autoindenting
"set smarttab   "tab uses shiftwidth instead of tabstop

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

" change the mapleader from \ to ,
let mapleader=","
" ,s = substitute the current word or selection
nnoremap <leader>s yiw:%s/<c-r>"/
vnoremap <leader>s y:%s/<c-r>"/
" ,c = copy the whole file contents into the clipboard
nnoremap <leader>c :%y*<CR>
" ,v = edit vimrc configuration
nnoremap <leader>v :e $HOME/vimfiles/vimrc<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost vimrc source $MYVIMRC
endif

" <F5> will save and run the file
nnoremap <F5> :w<CR>:!"%"<CR>

" Remap left and right arrow keys to indent/de-indent
" - normal mode
nmap <silent> <Left> <<
nmap <silent> <Right> >>
" - visual mode (also select the region again)
vmap <silent> <Left> <gv
vmap <silent> <Right> >gv

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * y/<C-R>"<CR>
vnoremap <silent> # y?<C-R>"<CR>

" Show search result in the middle of the screen
nnoremap n nzz
nnoremap N Nzz

" The sparkup and supertab plugin combination causes tab problems.
" Map sparkup next mapping to C-x instead of C-n to go around the problem:
let g:sparkupNextMapping = '<c-x>'

" Set encoding to utf-8 by default
set encoding=utf-8
