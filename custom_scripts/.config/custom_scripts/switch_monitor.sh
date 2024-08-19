#!/bin/bash
display_ports=$(~/.config/custom_scripts/detect_monitor.sh)

#######################################
# Restart Nitrogen and i3
# Globals:
#   SIZE    Array dimensions of background image
#######################################
restart_nitrogen_i3() {

    killall nitrogen
    sleep 0.5
    nitrogen --set-centered ~/Backgrounds/${SIZE}barcelona.png
    sleep 0.5
    i3 restart

}


if [ "$display_ports" = "HDMI-1-1" ]; then

    xrandr --output eDP-2 --auto --output eDP-2 --same-as $display_ports --output $display_ports --off
    sleep 0.1
    xrandr -r 60
    SIZE="2560x1600"

    restart_nitrogen_i3

elif [ "$display_ports" = "eDP-2" ] || [ "$display_ports" = "eDP-1" ]; then

    xrandr --output HDMI-1-1 --auto --output HDMI-1-1 --same-as $display_ports
    display_ports2=$(~/.config/custom_scripts/detect_monitor.sh)

    if [ "$display_ports2" != "eDP-2" ] && [ "$display_ports2" != "eDP-1" ]; then

        xrandr --output $display_ports --off
        SIZE="1920x1080"

        restart_nitrogen_i3

    else

        xrandr -r 60

    fi

fi
