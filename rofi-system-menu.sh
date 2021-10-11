#!/bin/bash

choices="Power Off / Shutdown
Restart / Reboot
Lock
Logout
Suspend
No / Cancel"

chosen=$(echo -e "$choices" | rofi -i -dmenu -p "System")

case "$chosen" in
  "Power Off / Shutdown") systemctl poweroff ;;
  "Restart / Reboot") systemctl reboot ;;
  "Lock") light-locker-command -l ;;
  "Logout") systemctl logout ;;
  "Suspend") systemctl suspend;;
  *) exit ;;
esac
