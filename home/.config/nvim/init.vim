set shell=/bin/bash
set nocompatible
filetype off

call plug#begin('~/.local/share/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'chrisbra/Colorizer'
Plug 'tpope/vim-surround'
Plug 'dag/vim-fish'
Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

filetype plugin indent on

colorscheme gruvbox
set background=dark
set relativenumber
set colorcolumn=80
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

let mapleader=' '

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>r :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>p :GFiles<cr>
nnoremap <leader>f gg=G
