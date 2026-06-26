#!/bin/bash

rm ~/.config/hypr/colors.lua
rm ~/.config/kitty/current-theme.conf
rm -rf ~/.config/kitty/themes
rm ~/.config/rofi/colors.rasi
rm ~/.config/waybar/colors.css
rm ~/.config/wlogout/colors.css

cp -r ~/.config/colorschemes/catppuccin/hypr/colors.lua ~/.config/hypr/
cp -r ~/.config/colorschemes/catppuccin/kitty/current-theme.conf ~/.config/kitty/
cp -r ~/.config/colorschemes/catppuccin/kitty/themes ~/.config/kitty
cp -r ~/.config/colorschemes/catppuccin/rofi/colors.rasi ~/.config/rofi
cp -r ~/.config/colorschemes/catppuccin/waybar/colors.css ~/.config/waybar
cp -r ~/.config/colorschemes/catppuccin/wlogout/colors.css ~/.config/wlogout


# Post Hooks

hyprctl reload
pkill waybar && waybar
