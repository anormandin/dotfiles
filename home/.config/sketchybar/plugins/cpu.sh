#!/bin/bash
CORES=$(sysctl -n hw.ncpu)
PCT=$(ps -A -o %cpu | awk -v c="$CORES" '{s+=$1} END {printf "%.0f", s/c}')
sketchybar --set "$NAME" label="$PCT%"
