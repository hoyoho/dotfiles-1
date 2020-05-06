" This must be first, it changes other options as side effect
set nocompatible " be iMproved, required
filetype off " required
filetype plugin indent on " detect file types

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'fatih/vim-go', { 'branch': 'master', 'do': ':GoUpdateBinaries' }
Plug 'buoto/gotests-vim'
Plug 'SirVer/ultisnips'
Plug 'stephpy/vim-yaml'
Plug 'jremmen/vim-ripgrep'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'MattesGroeger/vim-bookmarks'
Plug 'editorconfig/editorconfig-vim'
Plug 'Raimondi/delimitMate'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let mapleader="," " leader is comma

set clipboard=unnamed " use one clipboard

" Automatically resize screens to be equally the same
autocmd VimResized * wincmd =

" Colorscheme
syntax on
set background=dark
set t_Co=256

if (has("termguicolors"))
 set termguicolors
endif

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

" Status line
set laststatus=2 " Show status bar by default
let g:airline_theme='oceanicnext'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
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
set number relativenumber " set hybrid relative line numbers
set cmdheight=2 " Better display for messages
set updatetime=300 " You will have bad experience for coc diagnostic messages when it's default 4000.
set signcolumn=yes " always show signcolumns

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set maxmempattern=20000 " increase max memory for large files
set viminfo='1000 " Set oldfiles to 1000 last recently opened files

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


" Visual linewise up and down by default (and use gj gk to go quicker)
noremap j gj
noremap k gk

noremap % v%

" Do not show q: window
map q: :q

" Highlight last inserted text
nnoremap gV `[v`]

" Don't highlight the cursor line on the quickfix window
autocmd BufReadPost quickfix setlocal nocursorline

" Highlighting
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType python setlocal expandtab smarttab shiftwidth=2  softtabstop=2 tabstop=2
autocmd FileType markdown setlocal expandtab smarttab shiftwidth=4  softtabstop=4 tabstop=4 syntax=markdown
autocmd Filetype gitcommit setlocal spell textwidth=72
" Tmux
autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux

" Strace highlighting
autocmd BufRead,BufNewFile *.strace set filetype=strace

" Autoremove whitespaces
autocmd BufWritePre * :%s/\s\+$//e

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

" Breaking the habit
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Some useful quickfix shortcuts
":cc      see the current error
":cn      next error
":cp      previous error
":clist   list all errors
map <C-n> :cn<CR>
map <C-m> :cp<CR>

" Mappings to move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gvj

" Increment/Decrement
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Close quickfix easily
nnoremap <leader>a :cclose<CR>

" Matches are highlighted.
nnoremap <silent> <Enter> :nohl<Enter>

" Buffers
nnoremap <leader>t :vnew<cr>
nnoremap <leader>T :enew<cr>
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
map gl :ls<cr>

" Creating splits
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>s :split<cr>

" Save or exit quickly
nnoremap <silent> <leader>w :w!<CR>
nnoremap <silent> <leader>q :q!<CR>

" vim-multiple-cursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-i>'
let g:multi_cursor_prev_key='<C-y>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

" coc-nvim
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" vim-choosewin
" invoke with '-'
nmap  -  <Plug>(choosewin)

" vim-go
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim

let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_test_prepend_name = 1
let g:go_term_enabled = 1
let g:go_auto_type_info = 0
let g:go_auto_sameids = 1 " Automatically highlight matching identifiers.
let g:go_echo_command_info = 1
let g:go_term_close_on_exit = 0
let g:go_null_module_warning = 0

let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled=['govet', 'golint']
let g:go_list_type = 'quickfix'
let g:go_metalinter_command = "golangci-lint"
let g:go_metalinter_enabled = ['govet', 'unused', 'structcheck', 'varcheck', 'deadcode', 'typecheck', 'errcheck', 'staticcheck', "unconvert", "gosec", "gocognit", "wsl", "gosimple", "dupl", "bodyclose", "goconst"]

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 0
let g:go_highlight_operators = 1
let g:go_highlight_format_strings = 0
let g:go_highlight_function_calls = 0
let g:go_gocode_propose_source = 1
let g:go_modifytags_transform = 'camelcase'

let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
      \ }

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" create a go doc comment based on the word under the cursor
" kudos @fatih
function! s:create_go_doc_comment()
  norm "zyiw
  execute ":put! z"
  execute ":norm I// \<Esc>$"
endfunction

nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>

augroup go
  autocmd!
  autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <silent> <leader>c  <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <silent> <leader>d  <Plug>(go-def-split)
  autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)
  autocmd FileType go nmap <silent> <leader>i  <Plug>(go-info)
  autocmd FileType go nmap <silent> <leader>l  <Plug>(go-metalinter)
  autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <silent> <leader>dt <Plug>(go-def-tab)
  autocmd FileType go nmap <silent> <leader>te <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>v  <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <leader>ui :<C-u>call <SID>create_go_doc_comment()<CR>
  autocmd FileType go nmap <silent> <leader>x  <Plug>(go-doc-vertical)
  if has('nvim')
    autocmd FileType go nmap <silent> <leader>rt <Plug>(go-run-tab)
    autocmd FileType go nmap <silent> <leader>rs <Plug>(go-run-split)
    autocmd FileType go nmap <silent> <leader>rv <Plug>(go-run-vertical)
  endif

  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl

" Completion + Snippet
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['go=go', 'viml=vim', 'bash=sh']
let g:vim_markdown_conceal = 0
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1

" FZF
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '~20%' }

let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

" search history
nmap <silent> <leader>h :FzfHistory<cr>
imap <silent> <leader>h <esc>:<C-u>FzfHistory<CR>

" search across files in the current directory
nnoremap <C-p> :FzfFiles<cr>
nnoremap <C-p> <esc>:<C-u>FzfFiles<CR>

" search across git files
nnoremap <silent> <leader>gf :FzfGFiles<cr>

nnoremap <silent> <leader>b :FzfBuffers<cr>
nnoremap <silent> <leader>b <esc>:<C-u>FzfBuffers<CR>

command! ProjectFiles execute 'FzfFiles' s:find_git_root()
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
nnoremap <silent> <leader>pf :ProjectFiles<cr>

nmap <C-c> :FzfTags<cr>
imap <C-c> <esc>:<C-u>FzfTags<CR>

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,css,jade,html,haml,config,py,cpp,c,go,hs,rb,conf,rs}"
  \ -g "\!*.{min.js,swp,o,zip,tags}"
  \ -g "\!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* FzfRg
  \ call fzf#vim#grep(
  \   'rg --line-number --column --no-heading --hidden --ignore-case --follow --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%:wrap')
  \           : fzf#vim#with_preview('right:50%:hidden:wrap', '?'),
  \   <bang>0)

" Search specific
nmap <silent> <leader>rg :FzfRg<cr>
imap <silent> <leader>rg <esc>:<C-u>FzfRg<CR>

command! -bang -nargs=* FzfFind call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" Restore the last cursor position when opening files.
function! RestoreCursor()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
autocmd BufReadPost * call RestoreCursor()
