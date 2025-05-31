#!/usr/bin/env bash

source "$HOME/.config/scripts/display/utils.sh"

function in_array() {
    local val=$1; shift
    for item; do
        [ "$item" = "$val" ] && return 0
    done
    return 1
}

function main() {
    # HDMI -> eDP
    display_ports="$(detect_monitor)"

    hdmi_ports=("HDMI-1-1" "HDMI-1" "HDMI-2")
    edp_ports=("eDP-1" "eDP-2")

    if in_array "$display_ports" "${hdmi_ports[@]}"; then
        for edp in "${edp_ports[@]}"; do
            xrandr --output "$edp" --auto --same-as "$display_ports"
        done
        xrandr --output "$display_ports" --off
        sleep 0.5
        xrandr -r 60
        restart_all

        # eDP -> HDMI
    elif in_array "$display_ports" "${edp_ports[@]}"; then
        for hdmi in "${hdmi_ports[@]}"; do
            xrandr --output "$hdmi" --auto --same-as "$display_ports"
        done
        display_ports2="$(detect_monitor)"
        if ! in_array "$display_ports2" "${edp_ports[@]}"; then
            xrandr --output "$display_ports" --off
            restart_all
        else
            xrandr -r 60
        fi
    fi
}

main
