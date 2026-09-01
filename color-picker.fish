#!/usr/bin/env fish


set color (niri msg pick-color | tail -1 | cut -w -f 2)
# feels like a hack
test "$color" = "color"; and exit 0
wl-copy -n $color
notify-send -a "Color Picker" "Color $color copied to clipboard"
