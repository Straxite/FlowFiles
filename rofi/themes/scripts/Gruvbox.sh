#!/usr/bin/env bash

rm ~/.config/rofi/wallpaper/launcher.sh

cp -r ~/.config/rofi/wallpaper/Gruvbox/launcher.sh ~/.config/rofi/wallpaper

awww img ~/.config/backgrounds/Gruvbox/5m5kLI9.png --transition-type wipe --transition-fps 60 --transition-duration 1.7

matugen image ~/.config/backgrounds/Gruvbox/5m5kLI9.png --source-color-index 0 --type scheme-tonal-spot

notify-send "Theme Switcher" "Current Theme: Gruvbox"
