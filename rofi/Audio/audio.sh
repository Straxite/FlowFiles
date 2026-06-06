#!/usr/bin/env bash

dir="$HOME/.config/rofi/Audio/"
theme='style-1'

# Options
options="AudioMenu\nBluetoothMenu"

# Show rofi menu
chosen=$(printf "$options" | rofi -dmenu \
    -p "Select Layout" \
    -theme "${dir}/${theme}.rasi")

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
