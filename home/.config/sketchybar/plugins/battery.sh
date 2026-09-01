#!/bin/bash
source "$HOME/.config/theme-current/sketchybar-colors.sh"
PCT=$(pmset -g batt | grep -Eo "[0-9]+%" | head -1 | tr -d '%')
CHARGING=$(pmset -g batt | grep -c 'AC Power')
[ -z "$PCT" ] && exit 0
if [ "$CHARGING" -gt 0 ]; then ICON="" COLOR=$GREEN_COLOR
elif [ "$PCT" -gt 75 ]; then ICON="" COLOR=$ICON_COLOR
elif [ "$PCT" -gt 50 ]; then ICON="" COLOR=$ICON_COLOR
elif [ "$PCT" -gt 25 ]; then ICON="" COLOR=$YELLOW_COLOR
else ICON="" COLOR=$RED_COLOR; fi
sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR label="$PCT%"
