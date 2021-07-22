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

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File explorer
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Gruvbox colorscheme
Plug 'morhetz/gruvbox'

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

call plug#end()


" Quick switch to terminal (assumes vim is running inside tmux)
nnoremap <silent> <leader>tj :call system("tmux select-window -t terminal-j <Bar><Bar> tmux new-window -n terminal-j")<CR>
nnoremap <silent> <leader>tk :call system("tmux select-window -t terminal-k <Bar><Bar> tmux new-window -n terminal-k")<CR>
nnoremap <silent> <leader>tl :call system("tmux select-window -t terminal-l <Bar><Bar> tmux new-window -n terminal-l")<CR>

" VimWiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/'}]

nmap <leader>wx <Plug>VimwikiToggleListItem


" Fuzzy finder mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fw <cmd>Telescope grep_string<cr>


" Trigger auto completion
inoremap <silent><expr> <C-Space> coc#refresh()
" Auto complete with the selected item
inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Go to definition
nmap <leader>gd <Plug>(coc-definition)
" Rename symbol
nmap <leader>gr <Plug>(coc-rename)
" Find all references to symbol
nmap <leader>gs <Plug>(coc-references)
" Hover symbol
nnoremap <silent> <leader>gh :call CocActionAsync('doHover')<CR>
" Highlight symbol when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')


" Remove the file explorer arrows (I already have icons next to files/folders)
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
" When deleting a file also delete the related buffer without asking confirmation
let NERDTreeAutoDeleteBuffer=1
" Reveal the file for the active buffer in the file explorer
nnoremap <leader>ee :NERDTreeFind<CR>
" Toggle the file explorer
nnoremap <leader>et :NERDTreeToggle<CR>


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

" Automatically close the documentation window
autocmd CompleteDone * silent! pclose

let g:snipMate = {}
let g:snipMate.snippet_version = 1

" Gruvbox colorscheme
colorscheme gruvbox


" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Move between vertical splits
let g:gitgutter_map_keys = 0 " vim-gitgutter mappings interfer with <leader>h
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

" Fast switch to previous file
nnoremap <leader>p <C-^>

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

" Highlight yanked text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=225}
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
