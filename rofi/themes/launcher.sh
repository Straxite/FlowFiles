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

dir="$HOME/.config/rofi/themes"
theme='style-1'

## Run
#!/usr/bin/env bash

options="Catppuccin\nTokyoNight\nRandom"

# Show rofi menu
chosen=$(printf "$options" | rofi -dmenu \
    -p "Select Layout" \
    -theme "${dir}/${theme}.rasi")

# Exit if nothing selected
[ -z "$chosen" ] && exit 0

case "$chosen" in
    Catppuccin)
        ~/.config/rofi/themes/scripts/catppuccin.sh
        ;;
    TokyoNight)
        ~/.config/rofi/themes/scripts/TokyoNight.sh
        ;;
    Random)
        ~/.config/rofi/themes/scripts/Random.sh
        ;;
esac
