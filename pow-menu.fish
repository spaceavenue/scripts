#!/usr/bin/env fish


set selection (\
    printf "Lock\nSuspend\nLogout\nReboot\nShutdown" \
    | fuzzel --dmenu \
    -l 5 \
    -w 12 \
    --font "Iosevka Etoile:size=20" \
    --line-height 32 \
    --hide-prompt \
    --mesg "Power Menu: " \
    --message-color=ffd1dbff
)

switch $selection
  case Lock
		swaylock
  case Suspend
		swaylock && systemctl suspend
  case 	Logout
		niri msg action quit
  case Reboot
		reboot
  case Shutdown
		systemctl poweroff
  case '*'
    echo "? Whar"
end
