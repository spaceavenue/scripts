#!/usr/bin/env python3

import json
import subprocess
import time

stream = subprocess.Popen(
    ["niri", "msg", "--json", "event-stream"],
    stdout=subprocess.PIPE,
    text=True,
)

def wait_for_window(app_id):
    for line in stream.stdout:
        try:
            data = json.loads(line)
        except Exception:
            continue
        if "WindowOpenedOrChanged" in data:
            win = data["WindowOpenedOrChanged"]["window"]
            if win.get("app_id") == app_id:
                return win["id"]

subprocess.run(["niri", "msg", "action", "spawn", "--", "footclient", "-a", "foot-msc-rmpc", "-T", "rmpc", "rmpc"])
rmpc_id = str(wait_for_window("foot-msc-rmpc"))

subprocess.run(["niri", "msg", "action", "focus-window", "--id", rmpc_id])

subprocess.run(["niri", "msg", "action", "spawn", "--", "footclient", "-a", "foot-msc-cava", "-T", "cava", "cava"])
cava_id = str(wait_for_window("foot-msc-cava"))

stream.terminate()

subprocess.run(["niri", "msg", "action", "consume-or-expel-window-left", "--id", cava_id])
subprocess.run(["niri", "msg", "action", "set-window-height", "--id", cava_id, "30%"])
subprocess.run(["niri", "msg", "action", "focus-window", "--id", rmpc_id])
