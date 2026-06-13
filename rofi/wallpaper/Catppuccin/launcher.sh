#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10

dir="$HOME/.config/rofi/wallpaper"
theme='style-1'

## Run
#!/usr/bin/env bash

WALL_DIR="$HOME/.config/backgrounds/Catppuccin"

# Get sorted list of wallpapers (full paths)
WALLPAPERS=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) | sort)

# Pipe directly into rofi — DO NOT store in a variable first.
# Bash variables strip null bytes (\x00), which breaks the icon tag format.
# "basename\x00icon\x1f/full/path" is what rofi needs to render thumbnails.
SELECTED_NAME=$(echo "$WALLPAPERS" | while IFS= read -r img; do
    printf "%s\x00icon\x1f%s\n" "$(basename "$img")" "$img"
done | rofi -dmenu \
    -show-icons \
    -p "Select Wallpaper" \
    -theme "${dir}/${theme}.rasi")

# Exit if nothing selected
[ -z "$SELECTED_NAME" ] && exit 0

# Resolve basename back to full path
SELECTED=$(echo "$WALLPAPERS" | grep -F "/$(basename "$SELECTED_NAME")" | head -n 1)

# Fallback: if already a full path somehow, use it directly
[ -z "$SELECTED" ] && SELECTED="$SELECTED_NAME"

# Apply wallpaper with swww
awww img "$SELECTED" \
    --transition-type center \
    --transition-fps 60 \
    --transition-duration 1.7

# 🎨 Auto-generate colors with Matugen
matugen image "$SELECTED" --source-color-index 0 --type scheme-tonal-spot

sleep 1

notify-send "Wallpaper Switcher" "Wallpaper Successfully Changed"

# Optional: reload apps that depend on colors
