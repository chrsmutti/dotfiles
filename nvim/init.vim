" fish doesn't play all that well with others
set shell=/bin/bash

set nocompatible
filetype off

call plug#begin('~/.local/share/nvim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'

Plug 'tpope/vim-surround'

Plug 'dag/vim-fish'
Plug 'airblade/vim-gitgutter'
Plug 'maximbaz/lightline-ale'
Plug 'dikiaap/minimalist'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'w0rp/ale'
Plug 'rust-lang/rust.vim'
Plug 'autozimu/languageclient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }

Plug 'chrisbra/Colorizer'

call plug#end()
filetype plugin indent on

set autoindent
set hidden
set number
set relativenumber
set mouse=a
set inccommand=split

syntax on
set background=dark
set termguicolors
colorscheme minimalist

let mapleader="\<space>"
nnoremap <leader>r :source ~/.config/nvim/init.vim<cr>

nmap <leader>; :Buffers<cr>
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
nmap <leader>f gg=g<cr>
noremap <leader>p :read !xclip -sel clip -o<cr>
noremap <leader>c :w !xclip -sel clip<cr><cr> 
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

nnoremap <C-R> :%s///<left><left>
nnoremap <C-P> :Files<cr>

nnoremap <C-E> :vsplit<cr>
nnoremap <C-O> :split<cr>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-Left> <C-W><C-H>
nnoremap <C-Down> <C-W><C-J>
nnoremap <C-Up> <C-W><C-K>

nnoremap <M-Left> :vertical resize -5<cr>
nnoremap <M-Right> :vertical resize +5<cr>
nnoremap <M-Up> :resize -5<cr>
nnoremap <M-Down> :resize +5<cr>

nnoremap <silent> <C-B> :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<cr>

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
highlight ALEInfoSign ctermbg=NONE ctermfg=blue

let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }


let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
			\ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
			\ 'python': ['/usr/bin/pyls']
			\ }


let g:rustfmt_command = "rustfmt"
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 0
let g:rustfmt_emit_files = 1

let g:deoplete#enable_at_startup = 1

