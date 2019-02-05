function fish_prompt
	set_color --bold white
	echo -n (whoami)

	set_color --bold red
	echo -n '@'
	echo -n (hostname)" "

	set_color --bold red
	echo -n (prompt_pwd)

	set_color white
	printf '%s ' (__fish_git_prompt)

	if test -e package.json
		set_color --bold green
		echo -n "$mfizz_nodejs ("(node -v)") "
	end

	set_color --bold red
	if [ (whoami) = "root" ]
		echo -n '# '
	else
		echo -n " $firacode_equal_greater "
	end
  	set_color normal
end
