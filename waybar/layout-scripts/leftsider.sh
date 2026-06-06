#!/usr/bin/bash

rm ~/.config/waybar/config.jsonc
rm ~/.config/waybar/style.css
rm ~/.config/waybar/window.sh

cp -r ~/.config/waybar/theme/leftsider/config.jsonc ~/.config/waybar
cp -r ~/.config/waybar/theme/leftsider/style.css ~/.config/waybar
pkill waybar && waybar &


