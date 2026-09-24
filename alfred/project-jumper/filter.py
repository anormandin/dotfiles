#!/usr/bin/env python3
"""Alfred script filter: jump to a project in ~/Documents/dev.nosync or ~/dotfiles.

Enter opens a WezTerm tab cd'd there, ⌥Enter opens VS Code,
⌘Enter opens a WezTerm tab running claude.
"""
import json
import os
import subprocess

DEV = os.path.expanduser("~/Documents/dev.nosync")
EXTRA = [os.path.expanduser("~/dotfiles")]
SKIP = {"node_modules", ".git", "bin", "obj", "dist", "build", ".venv"}


def repos():
    out = subprocess.run(
        ["find", DEV, "-maxdepth", "4", "-type", "d", "-name", ".git",
         "-not", "-path", "*/node_modules/*"],
        capture_output=True, text=True).stdout
    found = {os.path.dirname(p) for p in out.splitlines()}
    found.update(EXTRA)
    return sorted(found, key=lambda p: os.path.getmtime(p), reverse=True)


def main():
    home = os.path.expanduser("~")
    items = []
    for path in repos():
        rel = os.path.relpath(path, DEV) if path.startswith(DEV) else "~" + path[len(home):]
        items.append({
            "uid": path,
            "title": os.path.basename(path),
            "subtitle": rel,
            "arg": path,
            "type": "file",
            "match": rel.replace("/", " ").replace("-", " ").replace("_", " "),
            "variables": {"action": "term"},
            "mods": {
                "alt": {"subtitle": "Open in VS Code", "variables": {"action": "code"}},
                "cmd": {"subtitle": "Open WezTerm tab running claude",
                        "variables": {"action": "claude"}},
            },
        })
    print(json.dumps({"items": items}))


main()
