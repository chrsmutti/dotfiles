#!/usr/bin/env fish
set DIR (cd (dirname (status -f)); and pwd) 

# mkdirs
mkdir -p ~/.config/nvim
mkdir -p ~/.config/fish
mkdir -p ~/.config/alacritty
mkdir -p ~/.local/share/nvim/site

# delete files
rm -f ~/.config/nvim/init.vim
rm -f ~/.config/fish/config.fish
rm -f ~/.config/alacritty/alacritty.yml
rm -f ~/.tmux.conf

# link
ln -s $DIR/nvim/init.vim ~/.config/nvim/init.vim
ln -s $DIR/fish/cinfig.fish ~/.config/fish/config.fish
ln -s $DIR/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s $DIR/tmux.conf ~/.tmux.conf
ln -s $DIR/nvim/site/autoload ~/.local/share/nvim/site/autoload
