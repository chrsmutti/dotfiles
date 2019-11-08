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

set PATH $PATH $HOME/.cargo/bin
set PATH $PATH $HOME/.local/bin
set PATH $PATH $HOME/.yarn/bin
set PATH $PATH $HOME/.rvm/bin
set PATH $PATH $GOBIN
set PATH $PATH /usr/local/bin

set SPACEFISH_EXEC_TIME_SHOW false
set SPACEFISH_PROMPT_ADD_NEWLINE false
set SPACEFISH_PROMPT_SUFFIXES_SHOW true
set SPACEFISH_CHAR_SUFFIX "  "

# no greeting
set fish_greeting

# aliases
alias vim nvim
alias ssh "env TERM=xterm-256color ssh"
alias sbt "env TERM=xterm-color sbt"
alias scala "env TERM=xterm-color scala -Dscala.color"

if [ -e ~/.cargo/bin/exa ]
    alias l 'exa'
    alias ls 'exa'
    alias ll 'exa -l'
    alias lll 'exa -la'
else
    alias l 'ls'
    alias ll 'ls -l'
    alias lll 'ls -la'
end

if [ -e /usr/local/bin/bat ]
    alias cat bat
end

if [ -e /usr/local/bin/fnm ]
    fnm env --multi | source
end