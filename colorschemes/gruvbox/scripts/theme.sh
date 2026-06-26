#!/bin/bash

rm ~/.config/hypr/colors.lua
rm ~/.config/kitty/current-theme.conf
rm -rf ~/.config/kitty/themes
rm ~/.config/rofi/colors.rasi
rm ~/.config/waybar/colors.css
rm ~/.config/wlogout/colors.css

cp -r ~/.config/colorschemes/gruvbox/hypr/colors.lua ~/.config/hypr/
cp -r ~/.config/colorschemes/gruvbox/kitty/current-theme.conf ~/.config/kitty/
cp -r ~/.config/colorschemes/gruvbox/kitty/themes ~/.config/kitty
cp -r ~/.config/colorschemes/gruvbox/rofi/colors.rasi ~/.config/rofi
cp -r ~/.config/colorschemes/gruvbox/waybar/colors.css ~/.config/waybar
cp -r ~/.config/colorschemes/gruvbox/wlogout/colors.css ~/.config/wlogout


# Post Hooks

hyprctl reload
pkill waybar && waybar
