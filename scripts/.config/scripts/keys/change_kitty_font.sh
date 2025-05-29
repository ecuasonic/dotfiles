#!/usr/bin/env bash

CONFIG_FILE=~/.config/kitty/kitty.conf
CURRENT_SIZE=$(grep "font_size" $CONFIG_FILE | awk '{print $2}')

function main() {
    if (( $# == 0 )); then
        echo "Current Font Size: $CURRENT_SIZE"
    elif (( $# == 1 )); then
        # Replace the old font size with the new font size in the configuration file
        sed -i "s/font_size[[:space:]]*$CURRENT_SIZE/font_size $1/" "$CONFIG_FILE"
        if pids=$(pidof kitty); then
            kill -SIGUSR1 $pids
        else
            echo "Error: Kitty is not running."
        fi
        # Print a message indicating the change
        sleep 0.1
        # clear
        echo "New Font Size: $1"
    else
        echo "No parameters = show current font size"
        echo "One parameter = change font size"
    fi
}

main "$1"
