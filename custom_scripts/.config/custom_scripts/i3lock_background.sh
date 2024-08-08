# .config/i3/config
# hack/scripts/rofi/powermenu.sh

xrandr_output=$(xrandr --listactivemonitors)
display_ports=$(echo "$xrandr_output" | awk '/^[[:space:]]*[0-9]+:/ {print $4}')

if [ "$display_ports" = "HDMI-1-1" ]; then
    SIZE="1920x1080"
elif [ "$display_ports" = "eDP-2" ] || [ "$display_ports" = "eDP-1" ]; then
    SIZE="2560x1600"
elif [ "$display_ports" = "LVDS-1" ]; then
    SIZE="1440x900"
fi

echo ~/Backgrounds/${SIZE}barcelona.png
