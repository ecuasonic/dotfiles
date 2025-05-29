#!/usr/bin/env bash

source /home/ecuas/.config/scripts/display/utils.sh

#######################################
# Restart Nitrogen and i3
# Globals:
#   SIZE    Array dimensions of background image
#######################################
function restart_nitrogen_i3() {

    killall nitrogen
    sleep 0.5
    new_background
    sleep 0.5
    nitrogen --set-centered "${HOME}/Backgrounds/output.png"
    sleep 0.5
    i3 restart
}

function restart_floating() {

    # Get screen width and height
    read -r width height < <(xrandr --listmonitors | tail -1 | awk '{print $3}' | awk -F'[/x]' '{print $1, $3}')

    # Make floating window 80% of screen size
    new_width=$((width * 80 / 100))
    new_height=$((height * 80 / 100))

    # Resize the focused window
    i3-msg "resize set ${new_width} ${new_height}"
}

function main() {
    # HDMI -> eDP
    display_ports="$(detect_monitor)"


    if [ "$display_ports" = "HDMI-1-1" ] || [ "$display_ports" = "HDMI-1" ] || [ "$display_ports" = "HDMI-2" ]; then
        xrandr --output eDP-1 --auto --output eDP-1 --same-as "$display_ports" --output "$display_ports" --off
        xrandr --output eDP-2 --auto --output eDP-2 --same-as "$display_ports" --output "$display_ports" --off
        sleep 0.5
        xrandr -r 60

    # eDP -> HDMI
    elif [ "$display_ports" = "eDP-2" ] || [ "$display_ports" = "eDP-1" ]; then
        xrandr --output HDMI-1-1 --auto --output HDMI-1-1 --same-as "$display_ports"
        xrandr --output HDMI-1 --auto --output HDMI-1-1 --same-as "$display_ports"
        xrandr --output HDMI-2 --auto --output HDMI-1-1 --same-as "$display_ports"
        display_ports2="$(detect_monitor)"
        if [ "$display_ports2" != "eDP-2" ] && [ "$display_ports2" != "eDP-1" ]; then
            xrandr --output "$display_ports" --off
        else
            xrandr -r 60
        fi
    fi
    restart_nitrogen_i3
    restart_floating
}

main
