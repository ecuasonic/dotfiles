#!/usr/bin/bash

# Path to the configuration file
CONFIG_FILE="/home/ecuas/.config/alacritty/alacritty.toml"

# Read the current font size from the configuration file
CURRENT_SIZE=$(grep "size\s" $CONFIG_FILE | awk '{print $3}' )

if (( $# == 0 )); then
    echo "Current Font Size: $CURRENT_SIZE"
elif (( $# == 1 )); then
    # Replace the old font size with the new font size in the configuration file
    sed -i "s/^\(size\s*=\s*\)$CURRENT_SIZE/\1$1/" "$CONFIG_FILE"

    # Print a message indicating the change
    sleep 0.1
    clear
    echo "New Font Size: $1"
else
    echo "No parameters = show current font size"
    echo "One parameter = change font size"
fi
