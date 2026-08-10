#!/usr/bin/env bash

options="Notch\nVelvetline\nClassy\nLeftSider\nDynamic-Island\nVelvetlineV2\nStock"

# Show rofi menu
chosen=$(printf "$options" | rofi -dmenu \
    -i -p "Select Layout" )

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
    LeftSider)
        ~/.config/waybar/layout-scripts/leftsider.sh
        ;;
    Dynamic-Island)
        ~/.config/waybar/layout-scripts/dynamic-island.sh
        ;;
    VelvetlineV2)
        ~/.config/waybar/layout-scripts/velvetlinev2.sh
        ;;
    Stock)
        ~/.config/waybar/layout-scripts/stock.sh
        ;;
esac
