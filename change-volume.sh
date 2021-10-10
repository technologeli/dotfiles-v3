if [ -z "$1" ]; then
    echo "Input volume change."
    exit 1
fi
for SINK in `pacmd list-sinks | grep 'index:' | cut -b12-`
do
  pactl set-sink-volume $SINK $1
done
