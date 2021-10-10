killall -q polybar
polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
