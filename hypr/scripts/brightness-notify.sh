
#!/usr/bin/env bash
# brightness-notify.sh
# Runs 24/7 and sends a desktop notification whenever brightness changes.
 
POLL_INTERVAL=0.1 # seconds between checks (100ms = near-instant response)
PREV_PCT=""
NOTIF_ID=0        # holds the live notification ID so each update replaces it
ICON_DIR="$HOME/.local/share/icons/brightness" # SVG icons live here
 
get_brightness_pct() {
    # brightnessctl get returns current raw value (e.g. 400)
    # brightnessctl max  returns max raw value    (e.g. 1200)
    local CURRENT MAX
    CURRENT=$(brightnessctl get 2>/dev/null)
    MAX=$(brightnessctl max 2>/dev/null)
 
    if [[ -z "$CURRENT" || -z "$MAX" || "$MAX" -eq 0 ]]; then
        echo ""
        return
    fi
 
    # Compute integer percentage
    awk "BEGIN {printf \"%d\", ($CURRENT / $MAX) * 100}"
}
 
notify_brightness() {
    local PCT="$1"
    local ICON TITLE MSG URGENCY
 
    if [ "$PCT" -eq 0 ]; then
        ICON="$ICON_DIR/brightness-off.svg"
        TITLE="Brightness: 0% 🌑"
        MSG="Screen is at minimum brightness"
        URGENCY="low"
    elif [ "$PCT" -le 33 ]; then
        ICON="$ICON_DIR/brightness-low.svg"
        TITLE="Brightness: ${PCT}% 🔅"
        MSG="Low brightness"
        URGENCY="low"
    elif [ "$PCT" -le 66 ]; then
        ICON="$ICON_DIR/brightness-medium.svg"
        TITLE="Brightness: ${PCT}% 🔆"
        MSG="Medium brightness"
        URGENCY="low"
    else
        ICON="$ICON_DIR/brightness-high.svg"
        TITLE="Brightness: ${PCT}% ☀️"
        MSG="High brightness"
        URGENCY="low"
    fi
 
    # Replace existing notification instead of stacking a new one
    NOTIF_ID=$(notify-send -u "$URGENCY" -i "$ICON" -t 2000 --replace-id="$NOTIF_ID" --print-id "$TITLE" "$MSG")
    echo "[$(date '+%H:%M:%S')] $TITLE — $MSG"
}
 
echo "[$(date '+%H:%M:%S')] brightness-notify daemon started (polling every ${POLL_INTERVAL}s)"
 
# Main loop
while true; do
    CURRENT_PCT=$(get_brightness_pct)
 
    if [[ -z "$CURRENT_PCT" ]]; then
        echo "[$(date '+%H:%M:%S')] WARNING: could not read brightness, retrying..."
        sleep "$POLL_INTERVAL"
        continue
    fi
 
    # Notify only when something changed
    if [[ "$CURRENT_PCT" != "$PREV_PCT" ]]; then
        notify_brightness "$CURRENT_PCT"
        PREV_PCT="$CURRENT_PCT"
    fi
 
    sleep "$POLL_INTERVAL"
done
