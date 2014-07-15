let mapleader=","
set encoding=utf-8
call pathogen#infect()
call pathogen#helptags()
set nocompatible
set backspace=indent,eol,start  " more powerful backspacing
" Now we set some defaults for the editor
set history=500     " keep 500 lines of command line history
set ruler       " show the cursor position all the time
set cursorline " Show the cursor line at all times
set showcmd     "Show incomplete commands
set autoindent
set showmatch
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set hlsearch
set clipboard+=unnamed

set wrapscan " Set the search scan to
set ignorecase
set laststatus=2
" Set the status line the way I like it
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n
set lazyredraw " Don't update the display while executing macros

"make indention easier
vnoremap < <gv
vnoremap > >gv
" Insert the current time
nnoremap <Leader>d "=strftime("%c")<CR>P
inoremap <Leader>d <C-R>=strftime("%c")<CR>
" Stolen from vimbits. Allows moving but staying in insert mode.
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l

" cd to the directory containing the file in the buffer
nmap <silent> <Leader>cd :lcd %:h<CR>
nmap <silent> <Leader>md :!mkdir -p %:p:h<CR>

" Turn off that stupid highlight search
nmap <silent> <Leader>n :nohls<CR>

"center search
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

"configure file complete to be list bash
set wildmode=list:longest:full
set wildmenu

" Make vim quiet.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


if has("win32")
    set guifont=DejaVu_Sans_Mono:h10:cANSI
else
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 13
endif

if has("gui_running")
    colors jellybeans
else
    colors elflord
endif

if match($TERM, "screen")!=-1
    set term=xterm
    let g:GNU_Screen_used = 1
else
    let g:GNU_Screen_used = 0
endif

""""""""""""""""""""""""""""""""
"""""        VCS           '""""
""""""""""""""""""""""""""""""""
let g:signify_mapping_toggle_highlight = '<leader>gh'
let g:signify_disable_by_default = 1
nmap <Leader>gv :SignifyToggle<CR>


""""""""""""""""""""""""""""""""
"""""      C++ Stuff       """""
""""""""""""""""""""""""""""""""
let g:syntastic_cpp_compiler_options = '-std=c++0x'
let g:syntastic_cpp_checkers = ['g++', 'cppcheck']
set statusline+=%=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""
"""""    Haskell Stuff     """""
""""""""""""""""""""""""""""""""
" use ghc functionality for Haskell files
au Bufenter *.hs compiler ghc

" configure browser for haskell_doc.vim
let g:haddock_browser = "/usr/bin/google-chrome"
" Install: sudo apt-get install haskell-platform-doc
let g:haddock_docdir = "/usr/share/doc/ghc-doc/html"

"""""""""""""""""""""""""""""""""
set number
filetype plugin indent on
syntax on
set spell spelllang=en_us
" Toggling Autowrap (from: http://vim.wikia.com/wiki/Toggle_auto-wrap)
set sr fo=roqm1 tw=78
im <C-B> <C-O>:setl sr! fo<C-R>=strpart("-+",&sr,1)<CR>=tc<CR>_<BS><Right>

set hidden
if version >= 703
    set cm=blowfish
    " Persistent Undo settings
    set undofile
    set undolevels=1000 " Maximum number of changes that can be undone
    set undoreload=10000 " Maximum number of lines to save for undo on a buffer reload
    if has("win32")
        set undodir=$TEMP//
    else
        set undodir=/tmp//
    endif
endif

""""""""""""""""""""""""""""""""
"""""     Latex Stuff      """""
""""""""""""""""""""""""""""""""
let g:tex_flavor='latex'

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a single file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup Out of Source Builds
""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("$HOME/.scripts/oosmake/oosmake"))
    set makeprg=$HOME/.scripts/oosmake/oosmake
endif

"" Tabluar
if exists(":Tabularize")
    nmap <Leader>t= :Tabularize /=<CR>
    vmap <Leader>t= :Tabularize /=<CR>
    nmap <Leader>t: :Tabularize /:\zs<CR>
    vmap <Leader>t: :Tabularize /:\zs<CR>
    nmap <Leader>t, :Tabularize /,\zs<CR>
    vmap <Leader>t, :Tabularize /,\zs<CR>
    nmap <Leader>t; :Tabularize /;\zs<CR>
    vmap <Leader>t; :Tabularize /;\zs<CR>
endif

" ctrlP config
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmp = 'CtrlPRoot'
nnoremap <leader>t :CtrlPMRU<CR>
nnoremap <leader>bp :CtrlPBuffer<CR>
let g:ctrlp_working_path_mode=0

"Airline
let g:airline_symbols = {}
let g:airline_symbols.space = "\ua0"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>


" -- Save backups in a common folder instead of in the working directory. End
"  with a double directory separator to create path independent filenames
if has("win32")
    set directory=$TEMP//
    set backupdir=$TEMP//
    let g:haddock_browser = "C:/Program Files/Internet Explorer/iexplore.exe"
else
    let g:haddock_browser = "/opt/google/chrome/google-chrome"
    set directory=/tmp//
    set backupdir=/tmp//
endif

"build tags
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>:!cscope -Rb<CR>:cs reset<CR>

"Tagbar
nmap <F8> :TagbarToggle<CR>
nnoremap <F5> :GundoToggle<CR>

if has("win32")
    " Remote SSH settings
    let g:netrw_cygwin= 0
    let g:netrw_scp_cmd = 'c:\"Program Files (x86)"\PuTTY\pscp.exe -q '
    let g:netrw_sftp_cmd= '"c:\"Program Files (x86)"\PuTTY\psftp.exe'
    let g:netrw_silent = 1
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Text and mail
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reformat paragraphs and list.
nnoremap <Leader>r gq}

" Delete trailing white space and Dos-returns and to expand tabs to spaces.
nnoremap <Leader>w :set et<CR>:retab!<CR>:%s/[\r \t]\+$//<CR>

autocmd BufRead,BufNewFile *.asciidoc,README,TODO,CHANGELOG,NOTES,ABOUT
        \ setlocal autoindent expandtab tabstop=8 softtabstop=2 shiftwidth=2 filetype=asciidoc
        \ textwidth=70 wrap formatoptions=tcqn
        \ formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+
        \ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>

au BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.txt set filetype=text
autocmd BufRead,BufNewFile CMakeLists.txt set filetype=cmake textwidth=0

autocmd Filetype text,tex set textwidth=80 fo+=cqt wm=0 
autocmd Filetype mail set textwidth=72


"a and w reformat the paragraph automatically and a new paragraph
"is indicated by lines not ending with white-space
if version>=700
    autocmd Filetype mail,text,tex set fo+=n spell
endif


