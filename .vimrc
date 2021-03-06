set showmode
set tabstop=4
set shiftwidth=4
set smarttab
set mouse=a

" Line numbers
set number

set wildmenu
set expandtab
set pastetoggle=<F2>

" use vim settings rather than Vi settings (much better)
set nocompatible

" allow backspacing over everythign in insert mode
set backspace=indent,eol,start

set backup
set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching

" CTRL-U in insert mode deletes a lot. use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors. Also switch on
" highlighting the last used search pattern.
:if &t_Co > 2 || has("gui_running")
:  syntax on set hlsearch
:endif

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

let mapleader=','
map <leader>l :bnext<cr>
map <leader>r :bprevious<cr>

map <leader>q :bprevious<bar>:bdelete #<cr>
map <leader><leader> <C-^>
map <C-l> gt
map <C-h> gT

" Easier 2 reach than esc key :)
inoremap kj <esc>
inoremap jj <esc>
inoremap df <esc>

"This unsets the 'last search pattern' register by hitting return
nnoremap <CR> :noh<CR><CR>

augroup _
  autocmd!
  " have Vim jump to the last position when reopening a file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" Convenient command to see the diff between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
:if !exists(":DiffOrig")
: command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
:endif

""""""""""""""""""""
" Tim's vim settings
"
"
" When coding, auto-indent by 4 spaces
" Note that this does NOT change tab into 4 spaces.
set shiftwidth=4

" Always replace tab with 8 spaces, except for makefiles
set expandtab
autocmd FileType make setlocal noexpandtab

" Settings when editing *.txt files
" - automatically indent lines according to previous lines
"   - replace tab with 8 spaces
"   - when tab key is hit, move 2 spaces instead of 8
"   - wrap text if line goes longer than 76 columns
"   - check spelling
autocmd FileType text setlocal autoindent expandtab softtabstop=2 textwidth=78 spell spelllang=eng_us

" Don't do spell-checking on Vim help files
autocmd FileType help setlocal nospell

" Prepend ~/.backup to backupdir so that Vim will look for that directory
" before littering the current dir with backups.
" You need to do "mkdir -p ~/.backup" for this to work.
set backupdir^=~/.backup/,/tmp//
set directory=.swp/,~/.swp',/tmp//
set undodir=.undo/,~/.undo/,/tmp//

" Ignore case when searching
" - override this setting by tacking on \c or \C to your search term
"   to make your search always case-insensitive or case-sensitive,
"   respectively.
set ignorecase

"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

" Cursor settings for Terminal on macOS
if $TERM_PROGRAM =~ "Terminal"
    let &t_SI.="\e[6 q" "SI = INSERT mode
    let &t_SR.="\e[4 q" "SR = REPLACE mode
    let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)
endif

" for iTerm2 on OSX
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" make cmdmode toggle via <Esc> more responsive
set ttimeoutlen=1

" Plugins "

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" always show a statusbar no matter how many window are open
set laststatus=2

" Color Scheme
syntax on
let g:onedark_termcolors=256
colorscheme onedark
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
