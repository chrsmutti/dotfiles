if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
    fish -c fisher
end

# envs
set -gx EDITOR nvim

set -gx GOPATH $HOME/Workspace/go
set -gx GOBIN $GOPATH/bin
set -gx GOSRC $GOPATH/src

set PATH $PATH $HOME/.cargo/bin
set PATH $PATH $HOME/.local/bin
set PATH $PATH $HOME/.yarn/bin
set PATH $PATH $HOME/.rvm/bin
set PATH $PATH $GOBIN

# no greeting
set fish_greeting

# aliases
abbr --add vim nvim
abbr --add ssh "env TERM=xterm-256color ssh"
abbr --add sbt "env TERM=xterm-color sbt"
abbr --add scala "env TERM=xterm-color scala -Dscala.color"

if [ -e ~/.cargo/bin/exa ]
    abbr --add l 'exa'
    abbr --add ls 'exa'
    abbr --add ll 'exa -l'
    abbr --add lll 'exa -la'
else
    abbr --add l 'ls'
    abbr --add ll 'ls -l'
    abbr --add lll 'ls -la'
end

if [ -e /usr/bin/bat ]
    abbr --add cat bat
end

# source
if [ -e ~/.local/share/icons-in-terminal/icons.fish ]
    source ~/.local/share/icons-in-terminal/icons.fish
end

# colors
set normal (set_color d3d7cf normal)
set magenta (set_color 75507b magenta)
set yellow (set_color c4a000 yellow)
set green (set_color 4e9a06 green)
set red (set_color cc0000 red)
set gray (set_color 555753)

set fish_color_normal d3d7cf white
set fish_color_command fish_color_normal
set fish_color_quote --bold fish_color_normal
set fish_color_redirection 06989a fish_color_normal
set fish_color_end fish_color_normal
set fish_color_error cc0000 red
set fish_color_param 3465a4 blue
set fish_color_comment --italics 4e9a06
set fish_color_match 3465a4 blue
set fish_color_operator --bold fish_color_normal
set fish_color_escape c4a000 yellow
