#!/usr/bin/bash

# get current workspace id
current_ws=$(hyprctl activeworkspace -j | jq '.id')


if [ "$1" -eq 'p']; then

else 
	max_ws=$(hyprctl workspaces -j | jq 'map(.id) | max')
	# judge: if is at the border, then create a new workspace
	if [ "$current_ws" -eq "$max_ws" ]; then
		next_ws=$((current_ws + 1))
		hyprctl dispatch workspace $next_ws
	else
		# otherwise jump to next workspace
		hyprctl dispatch workspace m+1
	fi

fi
# get the current max/min workspace id
max_ws=$(hyprctl workspaces -j | jq 'map(.id) | max')

