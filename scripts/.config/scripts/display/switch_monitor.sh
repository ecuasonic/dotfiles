#!/usr/bin/env bash

source "$HOME/.config/scripts/display/utils.sh"

#######################################
# Restart Nitrogen and i3
# Globals:
#   SIZE    Array dimensions of background image
#######################################
function restart_nitrogen_i3() {

    killall nitrogen
    new_background
    sleep 0.5
    nitrogen --set-centered "${HOME}/Backgrounds/output.png"
}

function restart_polybar_i3() {
    ~/.config/polybar/launch.sh
}

function restart_floating() {

    # Get screen width and height
    read -r width height < <(xrandr --listmonitors | tail -1 | awk '{print $3}' | awk -F'[/x]' '{print $1, $3}')

    # Make floating window 80% of screen size
    new_width=$((width * 80 / 100))
    new_height=$((height * 80 / 100))

    # Resize the focused window
    if i3-msg -t get_tree | jq '.. | select(.focused? == true) | .floating' | grep -q 'user_on'; then
        i3-msg "resize set ${new_width} ${new_height}"
    fi
}

function restart_all() {
    restart_polybar_i3
    restart_floating
    restart_nitrogen_i3
}

function main() {
    # HDMI -> eDP
    display_ports="$(detect_monitor)"


    if [ "$display_ports" = "HDMI-1-1" ] || [ "$display_ports" = "HDMI-1" ] || [ "$display_ports" = "HDMI-2" ]; then
        xrandr --output eDP-1 --auto --output eDP-1 --same-as "$display_ports" --output "$display_ports" --off
        xrandr --output eDP-2 --auto --output eDP-2 --same-as "$display_ports" --output "$display_ports" --off
        sleep 0.5
        xrandr -r 60
        restart_all

    # eDP -> HDMI
    elif [ "$display_ports" = "eDP-2" ] || [ "$display_ports" = "eDP-1" ]; then
        xrandr --output HDMI-1-1 --auto --output HDMI-1-1 --same-as "$display_ports"
        xrandr --output HDMI-1 --auto --output HDMI-1-1 --same-as "$display_ports"
        xrandr --output HDMI-2 --auto --output HDMI-1-1 --same-as "$display_ports"
        display_ports2="$(detect_monitor)"
        if [ "$display_ports2" != "eDP-2" ] && [ "$display_ports2" != "eDP-1" ]; then
            xrandr --output "$display_ports" --off
            restart_all
        else
            xrandr -r 60
        fi
    fi
}

main
