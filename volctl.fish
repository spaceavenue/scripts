#!/usr/bin/env fish


set -l cmd $argv[1]
set -l val $argv[2]

switch "$cmd"
  case u up
    test -z "$val"; and set val 0.05
    wpctl set-volume @DEFAULT_AUDIO_SINK@ $val+ -l 1.0

  case d down
    test -z "$val"; and set val 0.05
    wpctl set-volume @DEFAULT_AUDIO_SINK@ $val-

  case m mute
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

  case c micmute
    wpctl set-mute @DEFAULT_AUDIO_SOURCE toggle

  case '*'
    echo "Usage:"
    echo "  volctl u|up   [val] : Increase volume by val (default 0.05)"
    echo "  volctl d|down [val] : Decrease brightness by val (default 0.05)"
    echo "  volctl m|mute       : Mute Audio"
    echo "  volctl c|micmute    : Mute Mic"
    return 1
end

