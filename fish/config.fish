if status --is-interactive
	tmux attach ^ /dev/null; or tmux new ^ /dev/null
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
set -x editor nvim

set path $path $home/.cargo/bin
set path $path $home/.local/bin

# aliases
alias vim "nvim"
alias sbt "env term=xterm-color sbt"

# colors:
set fish_color_normal f8f8f2 # the default color
set fish_color_command f92672 # the color for commands
set fish_color_quote E6DB74 # the color for quoted blocks of text
set fish_color_redirection AE81FF # the color for IO redirections
set fish_color_end F8F8F2 # the color for process separators like ';' and '&'
set fish_color_error F8F8F2 --background=F92672 # the color used to highlight potential errors
set fish_color_param A6E22E # the color for regular command parameters
set fish_color_comment 75715E # the color used for code comments
set fish_color_match F8F8F2 # the color used to highlight matching parenthesis
set fish_color_search_match --background=49483E # the color used to highlight history search matches
set fish_color_operator AE81FF # the color for parameter expansion operators like '*' and '~'
set fish_color_escape 66D9EF # the color used to highlight character escapes like '\n' and '\x70'
set fish_color_cwd 66D9EF # the color used for the current working directory in the default prompt

# Additionally, the following variables are available to change the highlighting in the completion pager:
set fish_pager_color_prefix F8F8F2 # the color of the prefix string, i.e. the string that is to be completed
set fish_pager_color_completion 75715E # the color of the completion itself
set fish_pager_color_description 49483E # the color of the completion description
set fish_pager_color_progress F8F8F2 # the color of the progress bar at the bottom left corner
set fish_pager_color_secondary F8F8F2 # the background color of the every second completion
