#!/usr/bin/bash

rm ~/.config/waybar/config.jsonc
rm ~/.config/waybar/style.css

cp -r ~/.config/waybar/theme/blayer/config.jsonc ~/.config/waybar
cp -r ~/.config/waybar/theme/blayer/style.css ~/.config/waybar
cp -r ~/.config/waybar/theme/blayer/window.sh ~/.config/waybar
pkill waybar && waybar &


