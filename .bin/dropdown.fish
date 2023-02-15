#!/usr/bin/env fish
# https://github.com/wez/wezterm/issues/1751

set hidden_space 4

function main -a app
	set window (yabai -m query --windows | jq --arg app $app '.[] | select(.app==$app)')
	set is_visible (echo $window | jq '."is-visible"')
	set id (echo $window | jq '.id')

	if test -z "$is_visible"
		osascript \
			-e "on run (argv)" \
			-e "tell application (item 1 of argv) to activate" \
			-e "end" \
			-- "$app"
	else if $is_visible
		yabai -m window $id --space $hidden_space
		echo "$app hidden"
	else
		yabai -m window $id --space mouse && yabai -m window --focus $id
		echo "$app revealed"
	end
end

main $argv
