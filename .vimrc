" This must be first, it changes other options as side effect
set nocompatible
filetype off

set clipboard=unnamed

set noshelltemp

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'davidhalter/jedi-vim'
Plugin 'sjl/gundo.vim'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'fatih/vim-go'
Plugin 'pangloss/vim-javascript'
Plugin 'rust-lang/rust.vim'
Plugin 'ervandew/supertab'
"Plugin 'terryma/vim-multiple-cursors'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()

" Background
set t_Co=16
syntax enable

set background=dark
"let g:solarized_termcolors=16
let g:solarized_termtrans=1
colorscheme solarized

"let g:molokai_original = 1
"colorscheme molokai
let g:rehash256 = 1

" Status line
set laststatus=2
set noshowmode
" Settings for vim-airline
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Formatting
filetype plugin indent on " detect file types
set tabstop=4 " tab is four spaces
set softtabstop=4
set shiftwidth=4 " number of spaces to use for autoindenting
set shiftround " use multiple of shitfwidth when indenting
set expandtab " insert space characters whenever the tab key is pressed
"set backspace=indent,eol,start " Allow backspacing over autoindent, line breaks and start of insert action
set number " line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to
set showmatch " highlight matching [{()}]

" Searching
" set smartcase " smart case matching
" set ignorecase " case insestive

set incsearch " search as characters are entered
set hlsearch " highlight search terms
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent " fold based on indent level

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

let mapleader="," " leader is comma


set tw=79 " text width
set formatoptions-=t " don't automatically wrap text when typing
set nowrap " don't wrap lines
set title " change the terminal's title
set autoindent " autoidenting on
set copyindent " copy the previous indentation on autoindenting

" Enable mouse inside vim
set mouse=a

" History & Undo
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class " ignore extensions

" Matches are highlighted.
nnoremap <silent> <Enter> :nohl<Enter>

" Disable backup and swap files
set nobackup
set nowritebackup
set noswapfile
set hidden " It hides buffers instead of closing them

" Chef syntax
"autocmd FileType ruby,eruby set filetype=ruby.eruby.chef

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" xlose vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" strace highlighting
autocmd BufRead,BufNewFile *.strace set filetype=strace

" Gundo
nnoremap <F5> :GundoToggle<CR>

" autosave
"let g:auto_save = 1  " enable AutoSave on Vim startup

" Autoremove whitespaces
autocmd BufWritePre * :%s/\s\+$//e

"Python-specific settings
set foldmethod=indent
set foldlevel=99

" Split behavior
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Gist
let g:gist_clip_command = 'pbcopy' " Copy to clipboard
let g:gist_detect_filetype = 1 " Detect filetype by default
let g:gist_post_private = 1 " private gists by default
:imap <C-d> <C-o>diw

nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

au BufNewFile report*.md r ~/.vim/skeleton.md
