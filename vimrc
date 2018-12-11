" Use Vim settings, rather than Vi settings
set nocompatible

" Load plugins with vundle {{{
" Find out the path of the .vimrc file
let s:vimdir=fnamemodify($MYVIMRC, ":p:h")

" Use vundle for plugin management (if present):
" To install, open shell in ~/.vim folder:
"   $ git submodule init
"   $ git submodule update
"   $ vim -c :PluginInstall
if isdirectory(s:vimdir . "/bundle/Vundle.vim")
    filetype off " required for vundle
    " set the runtime path to include Vundle and initialize
    exe "set rtp+=" . s:vimdir . "/bundle/Vundle.vim"
    call vundle#begin(s:vimdir . '/bundle')
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " Plugins from github:
    Plugin 'kien/ctrlp.vim'
    " Use <leader>m to open list of recent files
    nnoremap <leader>m :CtrlPMRU<CR>
    let g:ctrlp_custom_ignore = '\v[\/](node_modules)$'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'scrooloose/syntastic'
    let g:pymode_python = 'python3'
    Plugin 'vim-airline/vim-airline'
    if has('gui_running')
        Plugin 'altercation/vim-colors-solarized'
        let s:colorscheme="solarized"
        let s:background="dark"
    endif
    Plugin 'tpope/vim-fugitive'
    " Use <leader>g to grep the current word
    nnoremap <leader>g yiw:Ggrep \b<c-r>"\b
    Plugin 'fatih/vim-go'
    " Use goimports instead of gofmt when saving files
    let g:go_fmt_command = "goimports"
    " Automatically show info about the code under cursor
    "let g:go_auto_type_info = 1
    " Show all output in quickfix list
    let g:go_list_type = "quickfix"
    " Change GoDef to use 'godef' instead of 'guru', as this works
    " better outside GOPATH
    let g:go_def_mode = 'godef'
    Plugin 'thinca/vim-localrc'
    Plugin 'digitaltoad/vim-pug' " Jade templates
    Plugin 'mfukar/robotframework-vim'
    Plugin 'tpope/vim-sensible'
    Plugin 'ervandew/supertab'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'vimwiki/vimwiki'
    "let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
    Plugin 'PProvost/vim-ps1'
    Plugin 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk='-reuse-instance'

    " All of your Plugins must be added before the following line
    call vundle#end()            " required
endif
" }}}

" Set options & misc settings {{{
" Run :h '<option>' to see what each option does
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set history=1000        " keep history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set lazyredraw          " Don't redraw screen too eagerly (eg. during macros)
set splitright          " Open vertical split to the right
set wildmenu            " Use menu when tabbing through options
set laststatus=2        " Always show statusline

set ttimeout            " time out for key codes
set ttimeoutlen=100     " wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=lastline

" Show tabs and trailing spaces
set list
set listchars=tab:\|\ ,trail:\ 

set exrc
set secure

" Tabs and indentation:
set expandtab
set shiftwidth=4
set smarttab            "tab uses shiftwidth for indent
set autoindent

set scrolloff=1         " Show at least one line under/above cursor
set sidescrolloff=5     " Show at least 5 chars left/right of cursor

" File management:
set nobackup
set noswapfile
set autoread
set hidden              " Allow unsaved changes in hidden buffers
set encoding=utf-8      " Set encoding to utf-8 by default

" Enable omni completion
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,longest

" Search related:
set ignorecase  " Search case-insensitively...
set smartcase   " ... unless there is a uppercase-letter in search string
set wrapscan    " Continue seatch from start of file when reaching end of file
set hlsearch    " highlightg the last used search pattern.
if has('reltime')
    " do incremental searching when timeout is possible
    set incsearch
endif

" Show the line numers:
set number
set norelativenumber

" Disable the error beep:
set noerrorbells

if v:version >= 800
    " Don't touch the end of file char automagically
    set nofixeol
endif

" In many terminal emulators the mouse works just fine, enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
    syntax on
endif

" Windows specific settings
if has("win32") || has("win64")
    set guifont=Consolas:h11:cDEFAULT
    " Remove toolbar from gui
    set guioptions-=T
endif

if has('langmap') && exists('+langremap')
    " Prevent that the langmap option applies to characters that result from a
    " mapping.  If set (default), this may break plugins (but it's backward
    " compatible).
    set nolangremap
endif

" UI customisation:
if exists("s:colorscheme")
    exec "colorscheme " . s:colorscheme
endif
if exists("s:background")
    exec "set background=" . s:background
endif

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

" assume .pas-files are delphi ones:
let pascal_delphi=1
" }}}

" Autocommands {{{
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection
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

        " Source the vimrc file after saving it
        autocmd BufWritePost $MYVIMRC source $MYVIMRC | :e
    augroup END
endif " has("autocmd")
" }}}

" Mappings {{{

" From defaults.vim:
" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

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
nnoremap <leader>w :up<CR>
" <leader>q = :q
nnoremap <leader>q :q<CR>
" <leader>1 = :!
nnoremap <leader>1 :!

" <F4>: toggle spell checking
nmap <F4> :call ToggleSpell()<CR>
imap <F4> <Esc>:call ToggleSpell()<CR>a
" <F5>: save and run the file
nnoremap <F5> :up<CR>:!"%"<CR>

" <leader>v = edit vimrc configuration
nnoremap <leader>v :e $MYVIMRC<CR>

" Remap tab and shift-tab to indent/de-indent
" - normal mode
nnoremap <S-Tab> <<
nnoremap <Tab> >>
" - visual mode (also select the region again)
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

"Select the region again after indent
vnoremap < <gv
vnoremap > >gv

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * y/<C-R>"<CR>
vnoremap <silent> # y?<C-R>"<CR>

" Show search result in the middle of the screen
nnoremap n nzz
nnoremap N Nzz

" Due to scandinavian keyboard, map tag jump
noremap <c-right> <c-]>
noremap <c-left> <c-t>

" also, map ,t to update tags file
nmap <leader>t :silent !ctags -R -f %:p:h\tags %:p:h\*.*<cr>

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

" Use ctrl-UP and ctrl-DOWN to show and hide the quickfix list
noremap <c-up> :copen<cr>
noremap <c-down> :cclose<cr>

" Text selected by left mouse is yanked to the * register
" (Can be pasted with MiddleMouse)
vnoremap <LeftRelease> "*ygv

" Use <leader>g to grep the current word
nnoremap <leader>g yiw:Ggrep \b<c-r>"\b

nnoremap j gj
nnoremap k gk

" Use scandinavian chars for square brackets
nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]

" Filter through awk
nnoremap <leader>a :%!awk ''<Left>
vnoremap <leader>a !awk ''<Left>
" }}}

" gl will open up the link under the cursor (in Windows)
nnoremap gl :execute "!start " . expand("<cfile>")<cr>
" }}}
