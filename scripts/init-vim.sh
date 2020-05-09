#!/usr/bin/env bash
pip3 install --user pynvim

mkdir -p ~/.local/share/nvim/site/autoload
curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -o ~/.local/share/nvim/site/autoload/plug.vim

nvim +PlugInstall +qall