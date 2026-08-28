#!/bin/bash
 
THRESHOLD=35
BATTERY_PATH="/sys/class/power_supply/BAT0/capacity"
ICON_DIR="$HOME/.local/share/icons/battery"
 
while true; do
    BATTERY=$(cat "$BATTERY_PATH")
 
    CHARGING=$(cat /sys/class/power_supply/BAT0/status)
 
    if [ "$BATTERY" -lt "$THRESHOLD" ] && [ "$CHARGING" != "Charging" ]; then
        notify-send "󱊡 Battery Agent" "Battery is at ${BATTERY}%. Please plug in your charger!" \
            --urgency=normal \
            --icon="$ICON_DIR/battery-low.svg"
    fi
 
    sleep 120  # Check every 60 seconds
done
