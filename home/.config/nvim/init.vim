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
call plug#end()

filetype plugin indent on

colorscheme gruvbox
set background=dark

let mapleader=' '

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>r :source ~/.config/nvim/init.vim<cr>
