if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
    fish -c fisher
end

# no greeting
set fish_greeting

# envs
set -gx LC_ALL en_US.UTF-8
set -gx EDITOR nvim

set -gx GOPATH $HOME/Workspace/go
set -gx GOBIN $GOPATH/bin
set -gx GOSRC $GOPATH/src
set -gx PIPENV_VENV_IN_PROJECT "enabled"

# path
set PATH $PATH /usr/local/bin
set PATH $PATH $HOME/.cargo/bin
set PATH $PATH $HOME/.local/bin
set PATH $PATH $HOME/.yarn/bin
set PATH $PATH $HOME/.rvm/bin
set PATH $PATH $GOBIN

set PATH $PATH $HOME/Library/Python/3.7/bin

# no greeting
set fish_greeting

# aliases
alias vim nvim
alias sbt "env TERM=xterm-color sbt"
alias scala "env TERM=xterm-color scala -Dscala.color"
alias python "python3"

# hbase aliases
if [ -e ~/.local/share/hbase/bin/hbase ]
    alias start-hbase "~/.local/share/hbase/bin/start-hbase.sh"
    alias stop-hbase "~/.local/share/hbase/bin/stop-hbase.sh"
    alias hbase "~/.local/share/hbase/bin/hbase"
end

# exa aliases
if [ -e ~/.cargo/bin/exa ]
    alias l 'exa'
    alias ls 'exa'
    alias ll 'exa -l'
    alias lll 'exa -la'
end

# bat alias
if [ -e /usr/local/bin/bat ]
    set -gx BAT_PAGER "less -RF"
    alias cat "bat -p" # no line numbers
    alias catl "bat"
end

if [ -e ~/.cargo/bin/cargo ]
    alias ca 'cargo'
end

# git aliases
alias gaa 'git add --all; and git commit -a'

# fish aliases
alias source_fish 'source ~/.config/fish/config.fish'

# fnm init
if [ -e /usr/local/bin/fnm ]
    fnm env --multi | source
end

# starship
starship init fish | source
