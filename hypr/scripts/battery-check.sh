#!/bin/bash
 
THRESHOLD=20
BATTERY_PATH="/sys/class/power_supply/BAT0/capacity"
 
while true; do
    BATTERY=$(cat "$BATTERY_PATH")
 
    CHARGING=$(cat /sys/class/power_supply/BAT0/status)
 
    if [ "$BATTERY" -lt "$THRESHOLD" ] && [ "$CHARGING" != "Charging" ]; then
        notify-send "󱊡 Battery Agent" "Battery is at ${BATTERY}%. Please plug in your charger!" \
            --urgency=critical \
            --icon=battery-low
    fi
 
    sleep 60  # Check every 60 seconds
done
