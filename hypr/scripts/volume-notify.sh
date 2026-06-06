#!/usr/bin/env bash

# Get volume
VOL=$(pamixer --get-volume)
MUTED=$(pamixer --get-mute)

if [ "$MUTED" = "true" ]; then
    notify-send -r 9991 -u low "🔇 Muted"
else
    notify-send -r 9991 -u low "🔊 Volume: ${VOL}%"
fi
