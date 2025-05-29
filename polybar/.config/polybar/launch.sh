#!/usr/bin/env bash

function kill_polybar {
    # Terminate already running bar instances
    killall -q polybar

    # Wait until the processes have been shut down
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
}

function launch_polybar {
    polybar -q top &
    polybar -q bottom &
}

function get_wireless_iface() {
    ip link | awk -F: '/state UP/ {print $2}' | while read -r iface; do
        if iw dev "$iface" info &>/dev/null; then
            echo "$iface"
            return 0
        fi
    done
    return 1
}

function export_options {
    # Font size:
    read -r height < <(xrandr --listmonitors | tail -1 | awk '{print $3}' | awk -F'[/x]' '{print $3}')
    export TEXT_FONT="Terminus:size=$(( height / 75 ));3"

    # Wireless-network interface:
    iface=$(get_wireless_iface)
    export WIFI_INTERFACE=$iface

    # Backlight:
    backlight=$(ls -1 /sys/class/backlight)
    export BACKLIGHT=$backlight
}

function main {
    kill_polybar
    export_options
    launch_polybar
}

main
