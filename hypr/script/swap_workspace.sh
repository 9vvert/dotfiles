#!/bin/bash
# get the current workspace name
cur_ws=$(hyprctl activeworkspace -j | jq -r '.name')

# get all window address in current workspace
clients_cur=$(hyprctl clients -j \
  | jq -r --arg ws "$cur_ws" '.[] | select(.workspace.name == $ws) | .address')

# move all window to swap-workspace
for addr in $clients_cur; do
  echo $addr
  hyprctl dispatch movetoworkspace "name:swap, address:$addr"
done

echo "a"
echo $cur_ws



# move from target to current
if [ "$1" = "next" ]; then
	hyprctl dispatch workspace r+1
elif [ "$1" = "prev" ]; then
	hyprctl dispatch workspace r-1
else
	exit -1
fi

echo "b"
target_ws=$(hyprctl activeworkspace -j | jq -r '.name')
clients_target=$(hyprctl clients -j \
  | jq -r --arg ws "$target_ws" '.[] | select(.workspace.name == $ws) | .address')
echo $target_ws
for addr in $clients_target; do
  hyprctl dispatch movetoworkspace "$cur_ws, address:$addr"
done

echo "c"

# move the window in swap-workspace to target window
hyprctl dispatch workspace name:swap
clients_swap=$(hyprctl clients -j \
  | jq -r --arg ws "swap" '.[] | select(.workspace.name == $ws) | .address')

for addr in $clients_swap; do
  hyprctl dispatch movetoworkspace "$target_ws, address:$addr"
done

# return back
hyprctl dispatch workspace $target_ws
