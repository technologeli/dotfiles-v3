#!/bin/bash

choices="Select\nFull"
path="/home/eli/Pictures/maim"
chosen=$(echo -e "$choices" | rofi -i -dmenu -p "Screenshot")

case "$chosen" in
    "Select") maim -su $path/$(date +%F-%H-%M-%S).png ;;
    "Full") maim -u $path/$(date +%F-%H-%M-%S).png ;;
    *) exit ;;
esac

# apply most recent photo to clipboard
ss=$(/bin/ls -Art $path | tail -n 1)
xclip -selection clipboard -t image/png -i "$path/$ss" 
