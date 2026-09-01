#!/bin/bash
source "$HOME/.config/theme-current/sketchybar-colors.sh"
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
if [ "$1" = "${FOCUSED:-1}" ]; then
  sketchybar --set "$NAME" background.drawing=on background.color=$ACCENT_COLOR \
    label.color=$ACCENT_TEXT_COLOR
else
  sketchybar --set "$NAME" background.drawing=off label.color=$DIM_COLOR
fi
