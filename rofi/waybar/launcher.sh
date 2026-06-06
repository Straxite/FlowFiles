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

dir="$HOME/.config/rofi/waybar"
theme='style-1'

## Run
#!/usr/bin/env bash

options="Notch\nVelvetline\nClassy\nDy-Notch\nBlayer\nLeftSider"

# Show rofi menu
chosen=$(printf "$options" | rofi -dmenu \
    -p "Select Layout" \
    -theme "${dir}/${theme}.rasi")

# Exit if nothing selected
[ -z "$chosen" ] && exit 0

case "$chosen" in
    Notch)
        ~/.config/waybar/layout-scripts/notch.sh
        ;;
    Velvetline)
        ~/.config/waybar/layout-scripts/velvetline.sh
        ;;
    Classy)
        ~/.config/waybar/layout-scripts/classy.sh
        ;;
    Dy-Notch)
        ~/.config/waybar/layout-scripts/dy-notch.sh
        ;;
    Blayer)
        ~/.config/waybar/layout-scripts/blayer.sh
        ;;
    LeftSider)
        ~/.config/waybar/layout-scripts/leftsider.sh
        ;;
esac
