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

if [ -e ~/.cargo/bin/exa ]
	set -u fish_user_abbreviations $fish_user_abbreviations 'l=exa'
	set -u fish_user_abbreviations $fish_user_abbreviations 'ls=exa'
	set -u fish_user_abbreviations $fish_user_abbreviations 'll=exa -l'
	set -u fish_user_abbreviations $fish_user_abbreviations 'lll=exa -la'
else
	set -u fish_user_abbreviations $fish_user_abbreviations 'l=ls'
	set -u fish_user_abbreviations $fish_user_abbreviations 'll=ls -l'
	set -u fish_user_abbreviations $fish_user_abbreviations 'lll=ls -la'
end

# envs
set -x EDITOR nvim
set -x BASE16_HOME ~/.base16-shell

set PATH $PATH $HOME/.cargo/bin
set PATH $PATH $HOME/.local/bin
set PATH $PATH $HOME/.yarn/bin

# aliases
set -u fish_user_abbreviations $fish_user_abbreviations 'vim=nvim'
set -u fish_user_abbreviations $fish_user_abbreviations 'sbt=env TERM=xterm-color sbt'
set -u fish_user_abbreviations $fish_user_abbreviations 'ssh=env TERM=xterm-256color ssh'
