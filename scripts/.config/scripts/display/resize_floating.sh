#!/bin/bash

# Get screen width and height
read width height < <(xrandr --listmonitors | tail -1 | awk '{print $3}' | awk -F'[/x]' '{print $1, $3}')

# Make floating window 80% of screen size
new_width = $((width * 80 / 100))
new_height = $((height * 80 / 100))

# Resize the focused window
i3-msg "resize set ${new_width} ${new_height}"
