#!/usr/bin/env bash

rm ~/.config/rofi/wallpaper/launcher.sh

cp -r ~/.config/rofi/wallpaper/Random/launcher.sh ~/.config/rofi/wallpaper

awww img ~/.config/backgrounds/Random/forza6.jpg --transition-type wipe --transition-fps 60 --transition-duration 1.7

matugen image ~/.config/backgrounds/Random/forza6.jpg --source-color-index 0 --type scheme-tonal-spot
