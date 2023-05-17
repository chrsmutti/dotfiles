set shell=/bin/bash
set nocompatible
filetype off

filetype plugin indent on

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

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

