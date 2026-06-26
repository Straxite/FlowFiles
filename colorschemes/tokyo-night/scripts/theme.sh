#!/bin/bash

rm ~/.config/hypr/colors.lua
rm ~/.config/kitty/current-theme.conf
rm -rf ~/.config/kitty/themes
rm ~/.config/rofi/colors.rasi
rm ~/.config/waybar/colors.css
rm ~/.config/wlogout/colors.css

cp -r ~/.config/colorschemes/tokyo-night/hypr/colors.lua ~/.config/hypr/
cp -r ~/.config/colorschemes/tokyo-night/kitty/current-theme.conf ~/.config/kitty/
cp -r ~/.config/colorschemes/tokyo-night/kitty/themes ~/.config/kitty
cp -r ~/.config/colorschemes/tokyo-night/rofi/colors.rasi ~/.config/rofi
cp -r ~/.config/colorschemes/tokyo-night/waybar/colors.css ~/.config/waybar
cp -r ~/.config/colorschemes/tokyo-night/wlogout/colors.css ~/.config/wlogout


# Post Hooks

hyprctl reload
pkill waybar && waybar
