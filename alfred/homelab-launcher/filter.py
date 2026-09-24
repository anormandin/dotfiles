#!/usr/bin/env python3
"""Alfred script filter: homelab services from the unifi repo's services.toml.

Enter opens the service URL, ⌥Enter opens the direct LAN address,
⌘Enter copies the IP. The unifi repo stays the single source of truth.
"""
import json
import os
import tomllib

SRC = os.path.expanduser("~/Documents/dev.nosync/unifi/docs/services.toml")


def main():
    try:
        with open(SRC, "rb") as f:
            services = tomllib.load(f).get("service", [])
    except FileNotFoundError:
        print(json.dumps({"items": [{
            "title": "services.toml not found", "subtitle": SRC, "valid": False}]}))
        return
    items = []
    for s in services:
        url = s.get("url")
        item = {
            "uid": s["name"],
            "title": s["name"],
            "subtitle": f"{url or s['ip']} — {s.get('desc', '')}",
            "arg": url or s["ip"],
            "match": f"{s['name']} {s.get('desc', '')}",
            "variables": {"action": "open" if url else "copy"},
            "mods": {
                "cmd": {"arg": s["ip"], "subtitle": f"Copy IP {s['ip']}",
                        "variables": {"action": "copy"}},
            },
        }
        if s.get("alt"):
            item["mods"]["alt"] = {"arg": s["alt"], "subtitle": f"Open direct {s['alt']}",
                                   "variables": {"action": "open"}}
        items.append(item)
    print(json.dumps({"items": items}))


main()
