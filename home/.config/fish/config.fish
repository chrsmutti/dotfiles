# no greeting
set fish_greeting

# envs
set -gx LC_ALL en_US.UTF-8
set -gx EDITOR nvim
set -gx COURSIER_BIN_DIR $HOME/.local/bin

# path
set PATH /usr/local/bin $PATH
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH

# aliases
alias vim nvim
alias python "python3"
alias untar "tar xvzf"

if [ -e ~/.cargo/bin/exa ]
    alias l 'exa'
    alias ls 'exa -lh'
    alias ll 'exa -lh'
    alias lll 'exa -lah'
end

if [ -e /usr/local/bin/bat ]
    set -gx BAT_PAGER "less -R"
    alias cat "bat -p --plain" # no line numbers
    alias less "bat -p" # no line numbers
    alias catl "bat"
end

if [ -e ~/.cargo/bin/cargo ]
    alias ca 'cargo'
end

alias gaa 'git add --all; and git commit -a'
alias gp 'git pull'
alias gf 'git fetch --all --prune'
alias gc 'git checkout'

alias source_fish 'source ~/.config/fish/config.fish'

if [ -e (which fnm 2>&1) ]
    fnm env | source
end

if [ -e (which pyenv 2>&1) ]
	pyenv init - | source
end

if [ -e (which starship 2>&1) ]
	starship init fish | source
end
