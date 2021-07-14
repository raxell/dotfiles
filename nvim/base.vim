" Set the leader key
let mapleader = " "
let maplocalleader = "  "

" Enalbe mouse support.
" To break the rules, you must first master them. [cit.]
set mouse=a

" Display line numbers
set number

" Enable syntax highlighting
syntax on

" Use UTF-8
set encoding=utf-8

" Show a few lines of context around the cursor when scrolling
set scrolloff=5

" Highlight current line
set cursorline

" Keep block cursor in insert mode too
set guicursor=

" Don't keep the searched words highlighted after the search is done
set nohlsearch

" Allow to have unwritten changes to a file and open a new file, without being
" forced to write the changes first
set hidden

" Use case insensitive search unless a capital letter is used, in that case
" the search become case sensitive
set smartcase
set ignorecase

" Don't create swap files
set noswapfile

" Highlight matches as I search
set incsearch

" Add an extra column at the beginning to show linting errors, etc...
set signcolumn=yes

" Visual autocomplete for command menu
set wildmenu

" Automatically indent when adding a curly bracket, etc..
set smartindent

" Tabs are 4 columns wide. Each indentation level is 4 spaces
set tabstop=4      " number of visual spaces per TAB
set softtabstop=4  " number of spaces inserted when hitting TAB
set shiftwidth=4   " number of spaces per (auto)indent (>>, <<, etc..)
set expandtab      " turns TAB into spaces

" Back to normal mode
imap jk <esc>
vmap jk <esc>

" Status line
set laststatus=2

" Milliseconds of inactivity after which the swap file will be written to disk.
" This also controls the update frequency of vim-gitgutter
set updatetime=100

" Auto reload a file as soon as it changes on disk
set autoread
au CursorHold * checktime

" Open the new window below the current one for horizontal splits
set splitbelow
" Open the new window to the right of the current one for vertical splits
set splitright

" Make preview window height half the size of the current window
exec 'set previewheight=' . string(winheight(0)/2)

