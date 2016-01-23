call pathogen#infect()
call pathogen#helptags()

" Selected parts from vimrc_example.vim
" =====================================
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep a backup file
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
" End of selected parts from vimrc_example.vim

" UI customisation:
if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized

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
set wrapscan
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

" assume .pas-files are delphi ones:
let pascal_delphi=1

" Show the line numers:
set number
set norelativenumber

" Disable the error beep:
set noerrorbells
"set visualbell
"set t_vb=

set hidden "allow unsaved changes in hidden buffers
filetype plugin indent on " use intending intelligence based on filetype

" change the leader from \ to <space>
" use map instead of mapleader, so that the showcmd will show \
" (instead of a non-visible space)
map <space> <leader>
" <leader>s = substitute the current word or selection
nnoremap <leader>s yiw:%s/<c-r>"/
vnoremap <leader>s y:%s/<c-r>"/
" <leader>c = copy the whole file contents into the clipboard
nnoremap <leader>c :%y*<CR>
" <leader>w = save the current file
nnoremap <leader>w :w<CR>
" <leader>m = open list of recent files (CtrlP plugin)
nnoremap <leader>m :CtrlPMRU<CR>

" <leader>v = edit vimrc configuration
nnoremap <leader>v :e $HOME/vimfiles/vimrc<CR>
" Source the vimrc file after saving it
augroup vimrc
	autocmd!
	autocmd bufwritepost vimrc source $MYVIMRC
augroup END

" <F5> will save and run the file
nnoremap <F5> :w<CR>:!"%"<CR>

" Remap left and right arrow keys to indent/de-indent
" - normal mode
nmap <silent> <Left> <<
nmap <silent> <Right> >>
" - visual mode (also select the region again)
vmap <silent> <Left> <gv
vmap <silent> <Right> >gv
vnoremap <silent> < <gv
vnoremap <silent> > >gv

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * y/<C-R>"<CR>
vnoremap <silent> # y?<C-R>"<CR>

" Show search result in the middle of the screen
nnoremap n nzz
nnoremap N Nzz

" Set encoding to utf-8 by default
set encoding=utf-8

" Due to scandinavian keyboard, map tag jump
noremap <c-right> <c-]>
noremap <c-left> <c-t>

" also, map ,t to update tags file
nmap <leader>t :silent !ctags -R -f %:p:h\tags %:p:h\*.*<cr>

" Enable omni completion
inoremap <c-space> <c-x><c-o>
set omnifunc=syntaxcomplete#Complete

" Windows specific settings
if has("win32") || has("win64")
	set guifont=Courier_New:h10:cDEFAULT
endif

" Use leader key to cut, copy and paste to system clipboard
vnoremap <leader>y "+y
vnoremap <leader>d "+d
vnoremap <leader>p "+p
vnoremap <leader>P "+P

nnoremap <leader>y "+y
nnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" Map for changing working directory to where the current file is located
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Shortcuts for esc in insert mode
inoremap jk <esc>
inoremap kj <esc>

" Always show statusline
set laststatus=2

" Show tabs and trailing spaces
set list
set listchars=tab:\|\ ,trail:\ 

" Ease dropping to command mode
nnoremap ö :

" Use <leader>g to grep the current word
nnoremap <leader>g yiw:Ggrep <c-r>"

" Remove toolbar from gui
set guioptions-=T

nnoremap j gj
nnoremap k gk
