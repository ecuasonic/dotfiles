#!/usr/bin/bash
xrandr_output=$(xrandr --listactivemonitors)
display_ports=$(echo "$xrandr_output" | awk '/^[[:space:]]*[0-9]+:/ {print $4}')

echo $display_ports
