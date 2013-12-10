""""""""""""""""""""""""
" VIMRC
"""""""""""""""""""""""""

" This must be first, it changes other options as side effect
set nocompatible 

" Use pathogen - plugins under the ~/.vim/bundle directory
" call pathogen#helptags()
" call pathogen#runtime_append_all_bundles()

" 256 bit colors
" set t_Co=256

" Background
set background=dark

" status line
set ruler " show line number on the bar
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
set laststatus=2 " always display the status line
set wildmenu " improved status line
set wildmode=list:longest,full

" Syntax highlighting
syntax on
filetype plugin indent on " detect file types

set title " change the terminal's title

set autoindent " autoidenting on
set copyindent " copy the previous indentation on autoindenting

" Line numbers and length
set number " line numbers
set tw=79 " text width
set formatoptions-=t " don't automatically wrap text when typing
set nowrap " don't wrap lines

" Use Q for paragraph formatting
vmap Q gq
vmap Q gqap

" History & Undo
set history=1000
set undolevels=1000

set wildignore=*.swp,*.bak,*.pyc,*.class " ignore extensions

" Formatting
set tabstop=4 " tab is four spaces
set softtabstop=4
set shiftwidth=4 " number of spaces to use for autoindenting
set shiftround " use multiple of shitfwidth when indenting
set expandtab " insert space characters whenever the tab key is pressed
set hlsearch " highlight search terms
set backspace=indent,eol,start " Allow backspacing over autoindent, line breaks and start of insert action

" Searching
set smartcase " smart case matching
set ignorecase " case insestive
set incsearch " incremental searching

" Matches are highlighted.
nnoremap <silent> <Enter> :nohl<Enter>

" Disable backup and swap files
set nobackup
set nowritebackup
set noswapfile
set hidden " It hides buffers instead of closing them

" highlight whitespaces
" set list
" set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Plugins

"NERDTree
map <C-n> :NERDTreeToggle<CR>

" Python-mode plugin - https://github.com/klen/python-mode

let g:pymode_lint_write = 1 " Disable pylint checking every save
let g:pymode_run_key = 'R' " Set key 'R' for run python code
let g:pymode_doc = 1 " Load show documentation plugin
let g:pymode_doc_key = 'K' " Key for show python documentation
let g:pymode_run = 1 " Load run code plugin
let g:pymode_run_key = '<leader>r' " Key for run python code
let g:pymode_lint = 1 " Load pylint code plugin
let g:pymode_lint_checker = "pyflakes,pep8,mccabe" " Switch pylint, pyflakes, pep8, mccabe code-checkers
let g:pymode_lint_onfly = 0 " Run linter on the fly
let g:pymode_lint_cwindow = 1 " Auto open cwindow if errors be finded
let g:pymode_lint_message = 1 " Show error message if cursor placed at the error line
let g:pymode_lint_signs = 1 " Place error signs
let g:pymode_lint_minheight = 3 " Minimal height of pylint error window
let g:pymode_lint_maxheight = 6 " Maximal height of pylint error window
let g:pymode_folding = 1 " Enable python folding
let g:pymode_motion = 1 " Enable python objects and motion
let g:pymode_virtualenv = 1 " Auto fix vim python paths if virtualenv enabled
let g:pymode_breakpoint = 1 " Load breakpoints plugin
let g:pymode_breakpoint_key = '<leader>b' " Key for set/unset breakpoint

" let g:pymode_utils_whitespaces = 1 " Autoremove unused whitespaces
" let g:pymode_indent = 1 " Enable pymode indentation

" Enable all python highlightings
let g:pymode_syntax_all = 1
let g:pep8_map='<leader>8'

" Enable pymode's custom syntax highlighting
" let g:pymode_syntax = 1

" Highlight "print" as function
" let g:pymode_syntax_print_as_function = 0

" Highlight indentation errors
" let g:pymode_syntax_indent_errors = g:pymode_syntax_all

" Highlight trailing spaces
" let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Highlight string formatting
" let g:pymode_syntax_string_formatting = g:pymode_syntax_all

" Highlight str.format syntax
" let g:pymode_syntax_string_format = g:pymode_syntax_all

" Highlight string.Template syntax
" let g:pymode_syntax_string_templates = g:pymode_syntax_all

" Highlight doc-tests
" let g:pymode_syntax_doctests = g:pymode_syntax_all

" Highlight builtin objects (__doc__, self, etc)
" let g:pymode_syntax_builtin_objs = g:pymode_syntax_all

" Highlight builtin functions
" let g:pymode_syntax_builtin_funcs = g:pymode_syntax_all

" Highlight exceptions
" let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all

" For fast machines
" let g:pymode_syntax_slow_sync = 0

" Load rope plugin
" let g:pymode_rope = 1

" Auto create and open ropeproject
" let g:pymode_rope_auto_project = 1

