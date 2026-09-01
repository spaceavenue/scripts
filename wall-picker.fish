#!/usr/bin/env fish
#!/usr/bin/env fish

# wallpaper directory
set WALLDIR "$HOME/mia/wal"
# extensions for wallpapers. png for blurred because swaylock
set EXT "qoz"
set EXT_BLUR "png"

function set_wallpaper
  set -l WALL $argv[1]
  if not test -f "$WALLDIR/blurred/$WALL.$EXT_BLUR"
      rustblur 3 3.0 "$WALLDIR/$WALL.$EXT" "$WALLDIR/blurred/$WALL.$EXT_BLUR"
  end

	ln -sf "$WALLDIR/$WALL.$EXT" "$HOME/.config/current_wallpaper"
	ln -sf "$WALLDIR/blurred/$WALL.$EXT_BLUR" "$HOME/.config/current_wallpaper_blurred"

	# for a smoother "transition",
	# get the current pids of all rustbg processes, start the new processes and kill the previous ones
	set -l prev_pids (pidof rustbg | string split ' ')
  
  niri msg action spawn -- "rustbg" "-f" "$HOME/.config/current_wallpaper"
  niri msg action spawn -- "rustbg" "-f" "-n" "wallpaper-overview" "$HOME/.config/current_wallpaper_blurred"
  sleep 0.2

  if test -n "$prev_pids"
    kill $prev_pids
  end
end

while true
    set WALL (ls -1 -I "blurred" -I "orig" $WALLDIR | path basename -E | fuzzel --dmenu --prompt "Wallpaper > ")
    test -z "$WALL" && exit 0
    set_wallpaper "$WALL"
    exit 0
end
