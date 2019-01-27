if not functions -q fundle
	eval (curl -sfL https://git.io/fundle-install)
end

if functions -q fundle
	fundle plugin 'tuvistavie/fish-ssh-agent'
	fundle plugin 'reitzig/sdkman-for-fish'
	fundle plugin 'smh/base16-shell-fish'
	fundle plugin 'oh-my-fish/theme-default'
	fundle plugin 'edc/bass'
	fundle plugin 'FabioAntunes/fish-nvm'

	fundle init
end

# envs
set -x EDITOR nvim
set -x BASE16_HOME ~/.base16-shell

set PATH $PATH $HOME/.cargo/bin
set PATH $PATH $HOME/.local/bin
set PATH $PATH $HOME/.yarn/bin

# aliases
abbr --add vim nvim

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
