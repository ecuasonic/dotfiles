$display_ports=$(./detect_monitor)

if [ $display_ports = "HDMI-1-1" ]; then
    SIZE="1920x1080"
elif [ $display_ports = "eDP-2" ] || [ $display_ports = "eDP-1" ]; then
    SIZE="2560x1600"
fi

i3lock -i ~/Backgrounds/${SIZE}barcelona.png
