display_ports=$(./detect_monitor.sh)

if [ $display_ports = "HDMI-1-1" ]; then
    SIZE="1920x1080"
elif [ $display_ports = "eDP-2" ] || [ $display_ports = "eDP-1" ]; then
    SIZE="2560x1600"
elif [ $display_ports = "LVDS-1" ]; then
    SIZE="1440x900"
fi

echo $SIZE
