#!/usr/bin/env fish
set DIR (cd (dirname (status -f)); and pwd) 

# mkdirs
mkdir -p ~/.config/nvim
mkdir -p ~/.config/fish
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/alacritty
mkdir -p ~/.local/share/nvim/site
mkdir -p ~/.tmux/plugins

# delete files
rm -f ~/.config/nvim/init.vim
rm -f ~/.config/fish/config.fish
rm -f ~/.config/alacritty/alacritty.yml
rm -f ~/.tmux.conf

# link
ln -s $DIR/nvim/init.vim ~/.config/nvim/init.vim
ln -s $DIR/fish/config.fish ~/.config/fish/config.fish
ln -s $DIR/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s $DIR/tmux.conf ~/.tmux.conf
ln -s $DIR/nvim/site/autoload ~/.local/share/nvim/site/autoload

for function_file in (ls $DIR/fish/functions)
	ln -s $DIR/fish/functions/$function_file ~/.config/fish/functions/$function_file
end

# clones
git clone https://github.com/chriskempson/base16-shell ~/.base16-shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
