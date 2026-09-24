#!/bin/bash
# $1 = URL or IP, $action = open|copy (set by the script filter item/mod)
if [ "$action" = "copy" ]; then
	printf '%s' "$1" | pbcopy
else
	open "$1"
fi
