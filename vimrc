" Use Vim settings, rather than Vi settings
set nocompatible

" Load plugins with vundle {{{
" Find out the path of the .vimrc file
let s:vimdir=fnamemodify($MYVIMRC, ":p:h")

" Use vim-plug for plugin management (if present):
if !empty(glob(s:vimdir . "/autoload/plug.vim"))
    call plug#begin(s:vimdir . '/plugged')

    " Plugins from github:
    Plug 'kien/ctrlp.vim'
    " Use <leader>m to open list of recent files
    nnoremap <leader>m :CtrlPMRU<CR>
    let g:ctrlp_custom_ignore = '\v[\/](node_modules)$'
    Plug 'scrooloose/nerdcommenter'
    let g:NERDCustomDelimiters = {
        \ 'c': { 'left': '//' },
    \ }
    Plug 'scrooloose/syntastic'
    let g:pymode_python = 'python3'
    Plug 'vim-airline/vim-airline'
    Plug 'morhetz/gruvbox'
    let s:colorscheme="gruvbox"
    Plug 'tpope/vim-fugitive'
    " Use <leader>g to grep the current word
    nnoremap <leader>g yiw:Ggrep \b<c-r>"\b
    Plug 'fatih/vim-go', {'for': 'go'}
    " Use goimports instead of gofmt when saving files
    let g:go_fmt_command = "goimports"
    " Use guru instead of gocode
    "let g:go_info_mode = 'guru'
    " Automatically show info about the code under cursor
    let g:go_auto_type_info = 1
    " Show all output in quickfix list
    let g:go_list_type = "quickfix"
    " Change GoDef to use 'godef' instead of 'guru', as this works
    " better outside GOPATH
    let g:go_def_mode = 'godef'
    Plug 'thinca/vim-localrc'
    Plug 'jupj/vim-mdo'
    Plug 'digitaltoad/vim-pug', {'for': 'pug'} " Jade templates
    Plug 'mfukar/robotframework-vim', {'for': 'robot'}
    Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
    Plug 'tpope/vim-sensible'
    Plug 'ervandew/supertab'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'vimwiki/vimwiki'
    "let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
    Plug 'PProvost/vim-ps1', {'for': 'ps1'}
    Plug 'lervag/vimtex', {'for': 'tex'}
    let g:tex_flavor='latex'
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk='-reuse-instance'
    " All plugins must be added before plug#end
    call plug#end()
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
set nojoinspaces        " Do not add two spaces between sentences

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
set belloff=all

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
set termguicolors
if exists('s:colorscheme') && !empty(globpath(&rtp, 'colors/' . s:colorscheme . '.vim'))
    exec "colorscheme " . s:colorscheme
    set background=dark
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

" netrw file browser settings:
let g:netrw_banner = 0 " hide banner
let g:netrw_browse_split = 4 " open files in last window
let g:netrw_winsize = 20 " use only 20% width of page
let g:netrw_liststyle = 3 " use tree-view

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
    augroup Jenkinsfile
        au!
        autocmd BufNewFile,BufRead Jenkinsfile setf groovy
        autocmd BufNewFile,BufRead Jenkinsfile.* setf groovy
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
" <leader>c = copy the whole file contents into the clipboard
nnoremap <leader>c :%y*<CR>
" <leader>w = save the current file
nnoremap <leader>w :up<CR>
" <leader>q = :q
nnoremap <leader>q :q<CR>
" Make it easier to search with scandinavian keyboard layout
nnoremap - /

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
" }}}

" gl will open up the link under the cursor (in Windows)
nnoremap gl :silent execute "!start " . expand("<cfile>")<cr>

" Go to window: <ctrl-[hjkl]>
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
" Go to window maps for terminal:
tnoremap <c-h> <c-w>h
tnoremap <c-j> <c-w>j
tnoremap <c-k> <c-w>k
tnoremap <c-l> <c-w>l

" Auto-close brackets
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap {<cr> {<cr>}<esc>O
inoremap {,<cr> {<cr>},<esc>O
" }}}
