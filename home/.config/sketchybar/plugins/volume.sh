#!/bin/bash
VOL="${INFO:-$(osascript -e 'output volume of (get volume settings)')}"
case "$VOL" in
  0) ICON="󰸈" ;;
  [1-9]|[1-4][0-9]) ICON="󰕿" ;;
  [5-9][0-9]) ICON="󰖀" ;;
  *) ICON="󰕾" ;;
esac
sketchybar --set "$NAME" icon="$ICON" label="$VOL%"
