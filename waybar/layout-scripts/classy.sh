#!/usr/bin/bash

rm ~/.config/waybar/config.jsonc
rm ~/.config/waybar/style.css
rm ~/.config/waybar/window.sh

cp -r ~/.config/waybar/theme/classy/config.jsonc ~/.config/waybar
cp -r ~/.config/waybar/theme/classy/style.css ~/.config/waybar
pkill waybar && waybar &

sleep 1

notify-send "Current Theme" "Classic Waybar"
