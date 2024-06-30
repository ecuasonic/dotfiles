display_ports=$(~/.config/custom_scripts/detect_monitor.sh)

if [ $display_ports = "HDMI-1-1" ]; then

    xrandr --output eDP-2 --auto --output eDP-2 --same-as $display_ports --output $display_ports --off
    sleep 0.1
    xrandr -r 60
    SIZE="2560x1600"

    killall nitrogen
    sleep 0.1
    nitrogen --set-centered ~/Backgrounds/${SIZE}barcelona.png
    i3 restart

elif [ "$display_ports" = "eDP-2" ] || [ "$display_ports" = "eDP-1" ]; then

    xrandr --output HDMI-1-1 --auto --output HDMI-1-1 --same-as $display_ports
    display_ports2=$(~/.config/custom_scripts/detect_monitor.sh)

    if [ "$display_ports2" != "eDP-2" ] && [ "$display_ports2" != "eDP-1" ]; then

        xrandr --output $display_ports --off
        SIZE="1920x1080"

        killall nitrogen
        sleep 0.1
        nitrogen --set-centered ~/Backgrounds/${SIZE}barcelona.png
        i3 restart


    else
        xrandr -r 60
    fi

fi


