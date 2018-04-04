" This must be first, it changes other options as side effect
set nocompatible " be iMproved, required
filetype off " required
filetype plugin indent on " detect file types

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'fatih/vim-go'
Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'zchee/deoplete-go'
Plugin 'zchee/deoplete-jedi'
Plugin 'rust-lang/rust.vim'
Plugin 'tpope/vim-surround'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'godlygeek/tabular'
Plugin 'elzr/vim-json'
Plugin 'plasticboy/vim-markdown'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ntpeters/vim-better-whitespace'
call vundle#end()

let mapleader="," " leader is comma

set clipboard=unnamed " use one clipboard

" Colorscheme
syntax on
set background=dark
set t_Co=256
let g:solarized_termcolors=16
let g:solarized_termtrans=1
colorscheme solarized

" Status line
set laststatus=2 " Show status bar by default
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 0 " Enable top tabline
let g:airline#extensions#branch#enabled = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_warning = ''
let g:airline_section_y = ''
let g:airline_section_x = ''

" Settings
set number " line numbers
set report=0 " Always report the number of lines changed
set showcmd " Show command in the bottom-right corner
set showmode " Show current mode
set autowrite " Writes the content of the file automatically if you call :make
set autoread " Automatically reread changed files without asking me anything
set autoindent " autoidenting on
set hidden " It hides buffers instead of closing them
set noshelltemp
set wildmenu " visual autocomplete for command menu
set lazyredraw " Redraw only when we need to
set nobackup " Disable backup and swap files
set nowritebackup
set noswapfile " Don't use swapfile
set noshowmatch " Do not show matching brackets by flickering
set noerrorbells " No beeps
set ruler " Show the cursor position all the time
set mouse=a " Enable mouse inside vim
set completeopt-=preview " remove the preview window

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Formatting
set tabstop=4 " tab is four spaces
set softtabstop=4
set shiftwidth=4 " number of spaces to use for autoindenting
set shiftround " use multiple of shitfwidth when indenting
set expandtab " insert space characters whenever the tab key is pressed
set wrap
set tw=79 " text width
set formatoptions-=t " don't automatically wrap text when typing
set title " change the terminal's title

" Searching
set incsearch " Search as characters are entered
set hlsearch " Highlight search terms
set ignorecase " Search case insensitive...
set smartcase " ... but not when search pattern contains upper case characters
set ttyfast

" Folding
set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
set foldmethod=indent " fold based on indent level

" History & Undo
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class " ignore extensions

" Speed up syntax highlighting
set nocursorcolumn " do not highlight column
set nocursorline " do not highlight line
syntax sync minlines=256 " start highlighting from 256 lines backwards

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Creating splits
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>

" Move up and down on splitted lines
map <Up> gk
map <Down> gj
map k gk
map j gj

" Leave insert mode
imap jk <ESC>l

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Matches are highlighted.
nnoremap <silent> <Enter> :nohl<Enter>

" Buffer prev/next
nnoremap <C-x> :bnext<CR>
nnoremap <C-z> :bprev<CR>

nnoremap gV `[v`] " Highlight last inserted text

" Breaking the habit
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Don't highlight the cursor line on the quickfix window
autocmd BufReadPost quickfix setlocal nocursorline

" Python settings
au FileType python set expandtab
au FileType python set smarttab
au FileType python set shiftwidth=4
au FileType python set softtabstop=4
au FileType python set tabstop=4

" Go settings
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

" YAML settings
au FileType yaml set expandtab
au FileType yaml set shiftwidth=2
au FileType yaml set softtabstop=2
au FileType yaml set tabstop=2

" Markdown settings
au FileType markdown set expandtab
au FileType markdown set shiftwidth=4
au FileType markdown set softtabstop=4
au FileType markdown set tabstop=4
au FileType markdown set syntax=markdown

" Strace highlighting
autocmd BufRead,BufNewFile *.strace set filetype=strace

" Autoremove whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" Autoload postmortems
au BufNewFile report*.md r ~/.vim/skeleton.md
au BufNewFile postmortem-*.md 0r ~/postmortem-templates/templates/postmortem-template-srebook.md

if has("autocmd")
    augroup templates
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
    augroup END
endif

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python %"
    endif
endfunction

" Deoplete
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#ignore_sources = {}
  let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file', 'neosnippet']
  let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
  let g:deoplete#sources#go#align_class = 1

  " Use partial fuzzy matches like YouCompleteMe
  call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
  call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])
  call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])
endif

" CtrlP
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_height = 10		" Maxiumum height of match window
let g:ctrlp_switch_buffer = 'et'	" Jump to a file if it's open already
let g:ctrlp_mruf_max=450 		" Number of recently opened files
let g:ctrlp_max_files=0  		" Do not limit the number of searchable files
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

" NERDTree
nmap <C-n> :NERDTreeToggle<CR>
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>
let NERDTreeShowHidden=1 " Show hidden files
"  Files to ignore
let NERDTreeIgnore = [
    \ '\.git$',
    \ '\.vim$',
    \ '\~$',
    \ '\.pyc$',
    \ '^\.DS_Store$',
    \ '^node_modules$',
    \ '^.ropeproject$',
    \ '^__pycache__$'
\]
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Gist
let g:gist_clip_command = 'pbcopy' " Copy to clipboard
let g:gist_detect_filetype = 1 " Detect filetype by default
let g:gist_post_private = 1 " private gists by default

" vim-go
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim

let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_snippet_engine = "neosnippet"
let b:goimports_vendor_compatible = 1
let g:go_autodetect_gopath = 1
let g:go_term_enabled = 1
let g:go_textobj_include_function_doc = 1
let g:go_auto_sameids = 1 " Automatically highlight matching identifiers.
let g:go_list_type = "quickfix"
let g:go_test_timeout = '10s'

let g:go_metalinter_autosave = 1 " Call metalinter after-save
let g:go_auto_type_info = 1 " Show the information - status line is updated automatically
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_operators = 0
let g:go_highlight_build_constraints = 1

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Build and run a Go program with <leader>b and <leader>r
au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
au FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <Leader>d <Plug>(go-doc)
au FileType go nmap <leader>dt  <Plug>(go-test-compile)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>l <Plug>(go-metalinter)
au FileType go nmap <leader>r  <Plug>(go-run)
au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <leader>t  <Plug>(go-test)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)

if has('nvim')
  au FileType go nmap <leader>rt <Plug>(go-run-tab)
  au FileType go nmap <Leader>rs <Plug>(go-run-split)
  au FileType go nmap <Leader>rv <Plug>(go-run-vertical)
endif

augroup go
  autocmd!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

" NeoSnippet Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
