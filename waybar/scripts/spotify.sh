#!/bin/bash

if playerctl -p spotify status &>/dev/null; then
    status=$(playerctl -p spotify status)
    title=$(playerctl -p spotify metadata title)
    artist=$(playerctl -p spotify metadata artist)

    if [ "$status" = "Playing" ]; then
        echo "   $artist - $title"
    else
        echo "   $artist - $title"
    fi
else
    echo "Blueberries X Winters"
fi
