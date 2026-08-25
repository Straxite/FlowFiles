#!/bin/bash

# Check if waybar is already running
if pgrep -x "waybar" > /dev/null
then
    # If it is running, kill it
    pkill waybar
else
    # If it's not running, start it
    waybar &
fi

