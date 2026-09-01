#!/bin/bash
# Workspace pill: highlight when focused, show when occupied, hide otherwise
source "$HOME/.config/theme-current/sketchybar-colors.sh"
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
if [ "$1" = "${FOCUSED:-1}" ]; then
  sketchybar --set "$NAME" drawing=on background.drawing=on \
    background.color=$ACCENT_COLOR label.color=$ACCENT_TEXT_COLOR
elif aerospace list-windows --workspace "$1" 2>/dev/null | grep -q .; then
  sketchybar --set "$NAME" drawing=on background.drawing=off label.color=$DIM_COLOR
else
  sketchybar --set "$NAME" drawing=off
fi
