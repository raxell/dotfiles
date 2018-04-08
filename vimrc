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

" Automatically indent when adding a curly bracket, etc..
set smartindent

" Tabs are four columns wide. Each indentation level is one hard tab (no spaces)
set shiftwidth=4
set tabstop=4

" Back to normal mode
imap jk <esc>
vmap jk <esc>

" Status line
set laststatus=2

" Milliseconds of inactivity after which the swap file will be written to disk.
" This also controls the update frequency of vim-gitgutter
set updatetime=100

" Open the new window below the current one for horizontal splits
set splitbelow
" Open the new window to the right of the current one for vertical splits
set splitright

" Install vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'danilo-augusto/vim-afterglow'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'kongo2002/fsharp-vim'

call plug#end()

" SublimeText color scheme
colorscheme afterglow

" Open terminal window
map <F12> <Esc>:exec 'term ++rows=' . string(&lines * 0.3)<CR><C-W>:set winfixheight<CR>

" Send selection to fsharpi (assumes that fsharpi is running in a terminal
" window located below the current one)
autocmd FileType fsharp vmap <C-M> "+y<C-W>j<C-W>"+;;<CR>

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

