#!/usr/bin/env bash

options="Notch\nVelvetline\nClassy\nDy-Notch\nBlayer\nLeftSider"

# Show rofi menu
chosen=$(printf "$options" | rofi -dmenu \
    -p "Select Layout" )

# Exit if nothing selected
[ -z "$chosen" ] && exit 0

case "$chosen" in
    Notch)
        ~/.config/waybar/layout-scripts/notch.sh
        ;;
    Velvetline)
        ~/.config/waybar/layout-scripts/velvetline.sh
        ;;
    Classy)
        ~/.config/waybar/layout-scripts/classy.sh
        ;;
    Dy-Notch)
        ~/.config/waybar/layout-scripts/dy-notch.sh
        ;;
    Blayer)
        ~/.config/waybar/layout-scripts/blayer.sh
        ;;
    LeftSider)
        ~/.config/waybar/layout-scripts/leftsider.sh
        ;;
esac

# For notification

notify-send "Waybar Layout Switcher" "Layout Successfully Switched"
