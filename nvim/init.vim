" Set the leader key
let mapleader = " "

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

" Install vim-plug automatically
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" =============================================================================
" PLUGINS
" =============================================================================

call plug#begin('~/.config/nvim/plugged')

Plug 'vimwiki/vimwiki'

" Start screen with recently opened files and sessions
Plug 'mhinz/vim-startify'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" SublimeText like colorscheme
Plug 'arcticicestudio/nord-vim'

" Collection of language plugins
Plug 'sheerun/vim-polyglot'

" Support for .editorconfig files
Plug 'editorconfig/editorconfig-vim'

" Show a statusline at the bottom of each window
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Jump to anywhere
Plug 'easymotion/vim-easymotion'

" Git wrapper commands
Plug 'tpope/vim-fugitive'

" Show which lines have been added, modified, or removed from the last commit
Plug 'airblade/vim-gitgutter'

" Comment/uncomment lines
Plug 'tpope/vim-commentary'

" Surround text with quotes, parenthesis, etc..
Plug 'tpope/vim-surround'

" Insert/delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Latex utils
Plug 'lervag/vimtex'

" Save and keep updated the current working session for subsequent starts
Plug 'tpope/vim-obsession'

" Snippet plugin with dependencies
Plug 'marcweber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

" Linting engine
Plug 'w0rp/ale'

" Comunication with a language server (allow go to definition, renaming, etc..)
Plug 'natebosch/vim-lsc'

call plug#end()


" VimWiki remappings
nmap <leader>wx <Plug>VimwikiToggleListItem


" Fuzzy finder mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fw <cmd>Telescope grep_string<cr>


" Easymotion config
" Disable default mappings
let g:EasyMotion_do_mapping = 0
" Set easymotion prefix
map <leader> <Plug>(easymotion-prefix)
" Jump to anywhere with 2 keystrokes
nmap <leader>s <Plug>(easymotion-overwin-f)
" Forward jump to work
nmap <leader>j <Plug>(easymotion-w)
" Backward jump to word
nmap <leader>k <Plug>(easymotion-b)

let g:airline_powerline_fonts = 1

" Treat riot files as regular html files to get syntax highlighting and linting
autocmd BufRead,BufNewFile *.riot set filetype=html

" Enable default mappings for LSP commands
let g:lsc_auto_map = v:true

" Map a filetype to the command that starts the language server for that filetype
let g:lsc_server_commands = {
\ 'dart': 'dart_language_server',
\ 'rust': 'rls',
\ 'typescript': 'javascript-typescript-stdio',
\}

" Allow javascript linters on html files
let g:ale_linter_aliases = {
\   'html': ['javascript']
\}

" Enable eslint on html files
let g:ale_linters = {
\   'html': ['eslint'],
\}

let g:ale_fixers = {
\ 'dart': ['dartfmt'],
\ 'javascript': ['eslint'],
\ 'html': ['eslint'],
\}
let g:ale_fix_on_save = 1

" Automatically close the documentation window
autocmd CompleteDone * silent! pclose

let g:snipMate = {}
let g:snipMate.snippet_version = 1

" Nord color scheme
colorscheme nord


" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Move/swap lines or selections
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Toggle relative line numbers
nnoremap <leader>n :set relativenumber!<CR>

" Switch between relative and absolute line numbers automatically
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" Fast change buffer
nnoremap <leader>b :ls<cr>:b<space>

" Change linter highlight colors and symbols
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '•'
highlight ALEErrorSign ctermbg=none ctermfg=088
highlight ALEWarningSign ctermbg=none ctermfg=031
highlight ALEError ctermbg=088
highlight ALEWarning ctermbg=031
