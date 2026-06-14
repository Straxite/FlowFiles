#!/usr/bin/env bash
# volume-notify.sh
# Runs 24/7 and sends a desktop notification whenever volume changes.
 
POLL_INTERVAL=0.1 # seconds between checks (100ms = near-instant response)
PREV_RAW=""
NOTIF_ID=0        # holds the live notification ID so each update replaces it
ICON_DIR="$HOME/.local/share/icons/volume" # SVG icons live here
 
get_volume_info() {
    local RAW
    RAW=$(wpctl get-volume @DEFAULT_SINK@ 2>/dev/null)
    echo "$RAW"
}
 
notify_volume() {
    local RAW="$1"
 
    # Check for muted flag
    if echo "$RAW" | grep -qi "MUTED"; then
        MUTED=true
    else
        MUTED=false
    fi
 
    # Extract numeric value (e.g. 0.65)
    local VOL_RAW
    VOL_RAW=$(echo "$RAW" | awk '{print $2}')
 
    # Convert to integer percentage
    local VOL_PCT
    VOL_PCT=$(awk "BEGIN {printf \"%d\", $VOL_RAW * 100}")
 
    local ICON TITLE MSG URGENCY
 
    if $MUTED; then
        ICON="$ICON_DIR/volume-muted.svg"
        TITLE="Volume: Muted "
        MSG="Current volume is ${VOL_PCT}% (muted)"
        URGENCY="normal"
    elif [ "$VOL_PCT" -eq 0 ]; then
        ICON="$ICON_DIR/volume-muted.svg"
        TITLE="Volume: 0% "
        MSG="Volume: Muted"
        URGENCY="low"
    elif [ "$VOL_PCT" -le 33 ]; then
        ICON="$ICON_DIR/volume-low.svg"
        TITLE="Volume: ${VOL_PCT}% 󰕿"
        MSG="Volume: Low"
        URGENCY="low"
    elif [ "$VOL_PCT" -le 66 ]; then
        ICON="$ICON_DIR/volume-medium.svg"
        TITLE="Volume: ${VOL_PCT}% 󰖀"
        MSG="Volume: Medium"
        URGENCY="low"
    elif [ "$VOL_PCT" -le 100 ]; then
        ICON="$ICON_DIR/volume-high.svg"
        TITLE="Volume: ${VOL_PCT}% 󰕾"
        MSG="Volume: High"
        URGENCY="low"
    else
        ICON="$ICON_DIR/volume-high.svg"
        TITLE="Volume: ${VOL_PCT}% 󰕾"
        MSG="Volume: V-High"
        URGENCY="normal"
    fi
 
    # --replace-id replaces the existing notification instead of stacking a new one.
    # notify-send prints the assigned ID which we capture for the next call.
    NOTIF_ID=$(notify-send -u "$URGENCY" -i "$ICON" -t 2000 --replace-id="$NOTIF_ID" --print-id "$TITLE" "$MSG")
    echo "[$(date '+%H:%M:%S')] $TITLE — $MSG  ($RAW)"
}
 
echo "[$(date '+%H:%M:%S')] volume-notify daemon started (polling every ${POLL_INTERVAL}s)"
 
# Main loop
while true; do
    CURRENT_RAW=$(get_volume_info)
 
    if [[ -z "$CURRENT_RAW" ]]; then
        echo "[$(date '+%H:%M:%S')] WARNING: could not read volume, retrying..."
        sleep "$POLL_INTERVAL"
        continue
    fi
 
    # Notify only when something changed
    if [[ "$CURRENT_RAW" != "$PREV_RAW" ]]; then
        notify_volume "$CURRENT_RAW"
        PREV_RAW="$CURRENT_RAW"
    fi
 
    sleep "$POLL_INTERVAL"
done
