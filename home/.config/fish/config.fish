function fish_greeting
end

if status is-interactive
    source "$HOME/.cargo/env.fish"

    fish_add_path "$HOME/.yarn/bin"
    fish_add_path "$HOME/.local/bin"

    set -gx GOPATH "$HOME/go"
    fish_add_path "$GOPATH/bin"

    fish_add_path "/opt/homebrew/bin"

    set -gx SDKMAN_DIR "$HOME/.sdkman"

    zoxide init fish --cmd=cd | source

    alias ls "exa"
    alias ll "exa -l"
    alias cat "bat"
    alias fish_reload "source ~/.config/fish/config.fish"

    alias gaa "git add --all; git commit -a"
    alias gc "git checkout"

	fnm env --use-on-cd --shell fish | source
end

# >>> coursier install directory >>>
set -gx PATH "$PATH:/Users/chrs/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
