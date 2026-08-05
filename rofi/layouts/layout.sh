#!/usr/bin/env bash

# Labels — change these to change what shows in the rofi menu
opt_wallpaper=" Wallpaper"
opt_waybar=" Waybar"
opt_theme=" Theme"

options="$opt_wallpaper\n$opt_waybar\n$opt_theme"

# Show rofi menu
chosen=$(printf "$options" | rofi -dmenu \
    -i -p "Select Layout")

# Exit if nothing selected
[ -z "$chosen" ] && exit 0

case "$chosen" in
    "$opt_wallpaper")
        ~/.config/rofi/wallpaper/launcher.sh
        ;;
    "$opt_waybar")
        ~/.config/rofi/waybar/launcher.sh
        ;;
    "$opt_theme")
        ~/.config/rofi/themes/launcher.sh
        ;;
esac
