#!/usr/bin/env bash

source "${HOME}/.config/scripts/display/utils.sh"
display_ports="$(detect_monitor)"

if [ "$display_ports" = "HDMI-1-1" ]; then

    xrandr --output eDP-2 --auto --output eDP-2 --same-as "$display_ports" --output "$display_ports" --off
    xrandr -r 60

    killall nitrogen
    sleep 0.1

    new_background
    sleep 0.5

    nitrogen --set-centered ~/Backgrounds/output.png
    sleep 0.1

    i3 restart
fi
