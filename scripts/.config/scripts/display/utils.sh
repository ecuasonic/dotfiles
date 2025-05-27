#!/usr/bin/env bash

function detect_monitor() {
    xrandr_output=$(xrandr --listactivemonitors)
    display_ports=$(echo "$xrandr_output" | awk '/^[[:space:]]*[0-9]+:/ {print $4}')

    echo "$display_ports"
}

function new_background() {
    display_size=$(xrandr --listmonitors | tail -1 | awk '{print $3}' | awk -F'[/x]' '{print $1"x"$3}')
    magick "${HOME}/Backgrounds/background.png" -resize "${display_size}"! "${HOME}/Backgrounds/output.png"
}

function i3lock_background() {
    new_background
    echo "${HOME}/Backgrounds/output.png"
}
