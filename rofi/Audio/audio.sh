#!/usr/bin/env bash


# Options
options="AudioMenu\nBluetoothMenu"

# Show rofi menu
chosen=$(printf "$options" | rofi -dmenu \
    -p "Select Layout" )

# Exit if nothing selected
[ -z "$chosen" ] && exit 0

case "$chosen" in
    AudioMenu)
        pavucontrol
        ;;
    BluetoothMenu)
        kitty --class bluetuith -e bluetuith
        ;;
esac
