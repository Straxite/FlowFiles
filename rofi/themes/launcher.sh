#!/usr/bin/env bash

options="Catppuccin\nTokyoNight\nRandom\nOneDark"

# Show rofi menu
chosen=$(printf "$options" | rofi -dmenu \
    -p "Select Layout" )

# Exit if nothing selected
[ -z "$chosen" ] && exit 0

case "$chosen" in
    Catppuccin)
        ~/.config/rofi/themes/scripts/catppuccin.sh
        ;;
    TokyoNight)
        ~/.config/rofi/themes/scripts/TokyoNight.sh
        ;;
    Random)
        ~/.config/rofi/themes/scripts/Random.sh
        ;;
    OneDark)
        ~/.config/rofi/themes/scripts/onedark.sh
        ;;
esac
