#!/usr/bin/env bash

options="Catppuccin\nTokyoNight\nRandom\nOneDark\nAnime\nRosePine\nGruvbox"

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
    Anime)
        ~/.config/rofi/themes/scripts/Anime.sh
        ;;
    RosePine)
        ~/.config/rofi/themes/scripts/RosePine.sh
        ;;
    Gruvbox)
        ~/.config/rofi/themes/scripts/Gruvbox.sh
        ;;
esac
