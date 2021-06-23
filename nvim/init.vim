let path = $HOME . '/dotfiles/nvim/'

let config_files = [
  \ 'base.vim',
\]

for filename in config_files
  exec 'source' path . '/' . filename
endfor

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


" VimWiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/'}]

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
