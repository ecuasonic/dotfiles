#!/bin/bash

# Path to the configuration file
CONFIG_FILE="/home/ecuas/dotfiles/alacritty/.config/alacritty/alacritty.toml"

# Read the current font size from the configuration file
CURRENT_SIZE=$(grep "size\s" $CONFIG_FILE | awk '{print $3}' )

# Determine the new font size
# if [ "$CURRENT_SIZE" -eq 9 ]; then
#     NEW_SIZE=12
# else
#     NEW_SIZE=9
# fi

# Replace the old font size with the new font size in the configuration file
sed -i "s/^\(size\s*=\s*\)$CURRENT_SIZE/\1$1/" "$CONFIG_FILE"

# Print a message indicating the change
echo "New Font Size: $1"
