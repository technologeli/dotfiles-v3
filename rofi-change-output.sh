#!/bin/bash

choices="Monitor
Logitech PRO Headset
Earbuds"

chosen=$(echo -e "$choices" | rofi -i -dmenu -p "Output")

audioscript="/home/eli/dotfiles-v3/change-output.sh"

case "$chosen" in
    Monitor) $audioscript 0 ;;
    Logitech\ PRO\ Headset) $audioscript 1 ;;
    Earbuds) $audioscript 2 ;;
    *) exit ;;
esac
