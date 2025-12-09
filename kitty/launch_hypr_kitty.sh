#!/bin/bash
kitty_normal_config="$HOME/.config/kitty/kitty_normal.conf"
kitty_hdmi_config="$HOME/.config/kitty/kitty_hdmi.conf"

if [ "$monitor_id" -eq 0 ]; then
	kitty --config $kitty_normal_config --working-directory "$(hyprcwd)"
else
	kitty --config $kitty_hdmi_config --working-directory "$(hyprcwd)"
fi
