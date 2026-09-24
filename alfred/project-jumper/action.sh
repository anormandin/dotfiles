#!/bin/bash
# $1 = project dir, $action = term|code|claude (set by the script filter)
dir="$1"
WEZ=/opt/homebrew/bin/wezterm

if [ "$action" = "code" ]; then
	open -a "Visual Studio Code" "$dir"
	exit 0
fi

if "$WEZ" cli list >/dev/null 2>&1; then
	pane=$("$WEZ" cli spawn --cwd "$dir" 2>/dev/null) \
		|| pane=$("$WEZ" cli spawn --new-window --cwd "$dir")
else
	open -a WezTerm
	i=0
	until "$WEZ" cli list >/dev/null 2>&1 || [ $i -ge 50 ]; do sleep 0.1; i=$((i+1)); done
	sleep 0.2
	pane=$("$WEZ" cli list --format json \
		| /usr/bin/python3 -c 'import json,sys; print(max(p["pane_id"] for p in json.load(sys.stdin)))')
	printf 'cd %q\n' "$dir" | "$WEZ" cli send-text --no-paste --pane-id "$pane"
fi

if [ "$action" = "claude" ]; then
	printf 'claude\n' | "$WEZ" cli send-text --no-paste --pane-id "$pane"
fi
osascript -e 'tell application "WezTerm" to activate'
