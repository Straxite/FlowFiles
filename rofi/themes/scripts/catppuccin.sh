#!/usr/bin/env bash

rm ~/.config/rofi/wallpaper/launcher.sh

cp -r ~/.config/rofi/wallpaper/Catppuccin/launcher.sh ~/.config/rofi/wallpaper

awww img ~/.config/backgrounds/Catppuccin/basement.jpg --transition-type wipe --transition-fps 60 --transition-duration 1.7

matugen image ~/.config/backgrounds/Catppuccin/basement.jpg --source-color-index 0 --type scheme-tonal-spot
