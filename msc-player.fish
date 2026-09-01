#!/usr/bin/env fish


niri msg action spawn -- "footclient" "rmpc" &&
sleep 0.1 &&
niri msg action spawn -- "footclient" "cava" &&
sleep 0.1 &&
niri msg action consume-or-expel-window-left &&
niri msg action set-window-height 30%
