scriptencoding utf-8
set encoding=utf-8

" This setting prevents vim from emulating the original vi's bugs and limitations.
set nocompatible
:set shortmess+=I

set hidden
" Set to auto read when a file is changed from the outside
set autoread

" Sets how many lines of history VIM has to remember
set history=1000
iab <expr> ddate strftime("%Y-%m-%d %H:%M")
syntax on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'mattn/zencoding-vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/peaksea'
Bundle 'jcf/vim-latex'
Bundle 'ivanov/vim-ipython'
Bundle 'goldfeld/vim-seek'

filetype plugin on
filetype indent on

" The first setting sets up 4-space tabs, and the second tells vi to use 4 spaces when text is indented
set tabstop=4
set shiftwidth=4
set softtabstop=4

set showmatch " Cause the cursor to very briefly jump to a brace/parenthese/bracket's
set ruler " Statusline that displays the current cursor position.
set autoindent
set smartindent

let mapleader = ","

if ! has("gui_running")
    set t_Co=256
endif 

set background=dark
colorscheme peaksea

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre *.py :call <SID>StripTrailingWhitespaces()

set encoding=utf8
try
	lang en_US
catch
endtry

set backspace=indent,eol,start
set wildmenu
set wildmode=list:longest
set wildchar=<Tab>
set ignorecase 
set smartcase
set number
set incsearch
set nobackup
set noswapfile

nnoremap ; :
nnoremap j gj
nnoremap k gk

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

nmap <silent> ,/ :nohlsearch<CR>

set scrolloff=7

"au FileType matlab map <buffer> <silent> <F5> :w<CR>:!/home/jeroen/.matlab_bin/bin/matlab -nodesktop -nosplash -r "try, run(which('%')); pause; end; quit" <CR>\\|<ESC><ESC>

"au FileType matlab set foldmethod=syntax foldcolumn=2 foldlevel=33
set spell
set spelllang=en_gb

nmap <silent> <leader>s :set spell!<CR>

" No sound on errors
set noerrorbells
set novisualbell 
set t_vb=

highlight Cursor guifg=black guibg=gray
highlight iCursor guifg=white guibg=white
set guicursor+=n-v-c:blinkon0-block-Cursor
set guicursor+=i:blinkon0-ver25-Cursor/lCursor

:set guioptions-=T  "remove toolbar
:set guioptions-=m  "remove menu
:set guioptions-=r  "remove right-hand scroll bar
autocmd! bufwritepost .vimrc source %

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/home/jeroen/phd/latex/thesis', "thesis", "g")
    let curdir = substitute(getcwd(), '/home/jeroen/vr', "vr", "g")
    let curdir = substitute(getcwd(), '/home/jeroen', "~", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

set nojoinspaces
set clipboard=unnamed

hi SpecialKey ctermfg=8 guifg=#333333
set guifont=Inconsolata\ 9

set listchars=trail:·,precedes:«,extends:»,tab:▸\ 
set list

fun! MendeleyFile()
   let l:Command = expand("<cword>")
   execute "!~/mendeley-file/mendeley-file " . l:Command
endfun

nmap <silent> <leader>pdf :silent call MendeleyFile()<CR>
