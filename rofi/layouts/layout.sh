#!/usr/bin/env bash

# Options
options="Wallpaper\nWaybar\nTheme"

# Show rofi menu
chosen=$(printf "$options" | rofi -dmenu \
    -p "Select Layout" )

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
