#!/usr/bin/bash

rm ~/.config/waybar/config.jsonc
rm ~/.config/waybar/style.css

cp -r ~/.config/waybar/theme/dy-notch/config.jsonc ~/.config/waybar
cp -r ~/.config/waybar/theme/dy-notch/style.css ~/.config/waybar
cp -r ~/.config/waybar/theme/dy-notch/window.sh ~/.config/waybar
pkill waybar && waybar &


