#!/usr/bin/env bash

dir="$HOME/.config/rofi/layouts/"
theme='style-1'

# Options
options="Wallpaper\nWaybar\nTheme"

# Show rofi menu
chosen=$(printf "$options" | rofi -dmenu \
    -p "Select Layout" \
    -theme "${dir}/${theme}.rasi")

# Exit if nothing selected
[ -z "$chosen" ] && exit 0

case "$chosen" in
    Wallpaper)
        ~/.config/rofi/wallpaper/launcher.sh
        ;;
    Waybar)
        ~/.config/rofi/waybar/launcher.sh
        ;;
    Theme)
        ~/.config/rofi/themes/launcher.sh
        ;;
esac
