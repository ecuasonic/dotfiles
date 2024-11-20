#!/usr/bin/env bash

display_ports=$(~/.config/scripts/detect_monitor.sh)

if [ "$display_ports" = "HDMI-1-1" ]; then

    xrandr --output eDP-2 --auto --output eDP-2 --same-as "$display_ports" --output "$display_ports" --off
    xrandr -r 60
    SIZE="2560x1600"

    killall nitrogen
    sleep 0.1
    nitrogen --set-centered ~/Backgrounds/${SIZE}barcelona.png
    sleep 0.1
    i3 restart
fi
