# Run xrandr and get the list of active monitors
xrandr_output=$(xrandr --listactivemonitors)

# Extract the display port names using awk
display_ports=$(echo "$xrandr_output" | awk '/^[[:space:]]*[0-9]+:/ {print $4}')

if [ $display_ports = "HDMI-1-1" ]; then
    SIZE="1920x1080"
elif [ $display_ports = "eDP-2" ]; then
    SIZE="2560x1600"
fi

i3lock -i ~/Backgrounds/${SIZE}barcelona.png
