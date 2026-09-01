#!/usr/bin/env fish


set -l bl_dir (path resolve /sys/class/backlight/* 2>/dev/null | head -n 1)

if test -z "$bl_dir" -o ! -d "$bl_dir"
    echo "error: no backlight device found in /sys/class/backlight/ !"
    return 1
end

set -l max_val (cat $bl_dir/max_brightness)
set -l cur_val (cat $bl_dir/brightness)
set -l device_name (path basename $bl_dir)

set -l cmd $argv[1]
set -l val $argv[2]

if test -n "$val"
    set val (string replace -r '%' '' -- "$val")
end

switch "$cmd"
  case i info ""
    set -l cur_pct (math -s0 "round($cur_val * 100 / $max_val)")
    echo "device: $device_name"
    echo "current brightness: $cur_val ($cur_pct%)"
    echo "max brightness: $max_val"

  case u up
    test -z "$val"; and set val 10
    set -l raw_step (math -s0 "max(1, round($max_val * $val / 100))")
    set -l new_val (math -s0 "min($max_val, $cur_val + $raw_step)")

    echo $new_val | tee $bl_dir/brightness > /dev/null
    set -l actual_pct (math -s0 "round($new_val * 100 / $max_val)")
    echo "brightness set to $actual_pct%"

  case d down
    test -z "$val"; and set val 10
    set -l raw_step (math -s0 "max(1, round($max_val * $val / 100))")
    set -l new_val (math -s0 "max(1, $cur_val - $raw_step)")

    echo $new_val | tee $bl_dir/brightness > /dev/null
    set -l actual_pct (math -s0 "round($new_val * 100 / $max_val)")
    echo "brightness set to $actual_pct%"

  case s set
    if test -z "$val"
      echo "error: 'set' requires a percentage value !"
      return 1
    end

    set -l target_val (math -s0 "round($max_val * $val / 100)")
    set -l new_val (math -s0 "max(1, min($max_val, $target_val))")

    echo $new_val | tee $bl_dir/brightness > /dev/null
    set -l actual_pct (math -s0 "round($new_val * 100 / $max_val)")
    echo "brightness set to $actual_pct%"

  case '*'
    echo "Usage:"
    echo "  blctl info       : Show current brightness info"
    echo "  blctl up [val]   : Increase brightness by val% (default 10)"
    echo "  blctl down [val] : Decrease brightness by val% (default 10)"
    echo "  blctl set <val>  : Set brightness to val%"
    return 1
end
