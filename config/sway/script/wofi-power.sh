#!/usr/bin/env bash

# A rofi-like System/Exit menu for wofi

selected=$(wofi --show dmenu --line=4 --cache-file /dev/null --prompt=System cat <<EOF
 Lock
 Logout
 Reboot
 Shutdown
EOF
)

case "$selected" in

    *Lock) swaylock -f -i ~/.config/sway/img/orbit-station.png ;;

    *Logout) swaymsg exit ;;

    *Reboot) systemctl reboot ;;

    *Shutdown) systemctl -i poweroff ;; 

esac

exit 0
