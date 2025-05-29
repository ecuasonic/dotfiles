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

function export_options {
    # Get screen dimensions, then calculate bar height + text size.
    read -r height < <(xrandr --listmonitors | tail -1 | awk '{print $3}' | awk -F'[/x]' '{print $3}')
    export BAR_HEIGHT=$(( height / 40 ))
    export TEXT_FONT="Terminus:size=$(( height / 75 ));3"

    # Bar options
}

function main {
    kill_polybar
    export_options
    launch_polybar
}

main
