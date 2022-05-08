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
set -gx COURSIER_BIN_DIR $HOME/.local/bin

# path
set PATH /usr/local/bin $PATH
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH $HOME/.yarn/bin $PATH
set PATH $HOME/.rvm/bin $PATH
set PATH $GOBIN $PATH

# no greeting
set fish_greeting

# aliases
alias vim nvim
alias python "python3"
alias untar "tar xvzf"

function sbt
    TERM=xterm-color command sbt $argv
end

function scala
    TERM=xterm-color command scala -Dscala.color $argv
end

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
    set -gx BAT_PAGER "less -R"
    alias cat "bat -p --plain" # no line numbers
    alias catl "bat"
end

if [ -e ~/.cargo/bin/cargo ]
    alias ca 'cargo'
end

# git aliases
alias gaa 'git add --all; and git commit -a'
alias gp 'git pull'
alias gf 'git fetch --all --prune'
alias gc 'git checkout'

# fish aliases
alias source_fish 'source ~/.config/fish/config.fish'

# fnm init
if [ -e /usr/local/bin/fnm ]
    fnm env | source
end

# pyenv init
pyenv init - | source

# starship
starship init fish | source
