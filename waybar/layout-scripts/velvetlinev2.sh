#!/usr/bin/bash

rm ~/.config/waybar/config.jsonc
rm ~/.config/waybar/style.css
rm ~/.config/waybar/window.sh

cp -r ~/.config/waybar/theme/velvetlineV2/config.jsonc ~/.config/waybar
cp -r ~/.config/waybar/theme/velvetlineV2/style.css ~/.config/waybar
pkill waybar && waybar &

sleep 1


notify-send "Current Theme" "Velvetline - Version2"
