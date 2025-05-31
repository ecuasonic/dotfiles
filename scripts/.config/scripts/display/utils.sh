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

# =============================================================================

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
