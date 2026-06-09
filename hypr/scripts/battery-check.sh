#!/bin/bash
 
THRESHOLD=20
BATTERY_PATH="/sys/class/power_supply/BAT0/capacity"
 
while true; do
    BATTERY=$(cat "$BATTERY_PATH")
 
    if [ "$BATTERY" -lt "$THRESHOLD" ]; then
        notify-send "󱊡 Battery Agent" "Mate your battery is at ${BATTERY}%. Plug in your charger!!" \
            --urgency=critical \
            --icon=battery-low
    fi
 
    sleep 30  # Check every 60 seconds
done
