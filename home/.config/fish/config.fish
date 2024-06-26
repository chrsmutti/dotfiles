function fish_greeting
end

fish_add_path "$HOME/.cargo/bin"

# fnm (should be installed via cargo)
fnm env | source

# yarn
fish_add_path "$HOME/.yarn/bin"
fish_add_path "$HOME/.local/bin"

# go
set -gx GOPATH "$HOME/go"
fish_add_path "$GOPATH/bin"

# homebrew
fish_add_path "/opt/homebrew/bin"

# pyenv
set -gx PYENV_ROOT "$HOME/.pyenv"
if test -e "$PYENV_ROOT/bin"
    fish_add_path "$PYENV_ROOT/bin"
    pyenv init - | source
end

# sdkman
set -gx SDKMAN_DIR "$HOME/.sdkman"

# nvim
set -gx EDITOR "nvim"
alias vim "nvim"

# zoxide
zoxide init fish --cmd=cd | source

# ocaml
eval (opam env)

# aliases
alias ls "exa"
alias ll "exa -l"
alias cat "bat"
alias fish_reload "source ~/.config/fish/config.fish"

alias gaa "git add --all; git commit -a"
alias gc "git checkout"

starship init fish | source

