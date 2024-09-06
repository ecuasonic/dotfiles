#!/usr/bin/bash

display_size=$(xrandr --listmonitors | tail -1 | awk '{print $3}' | awk -F'[/x]' '{print $1"x"$3}')
echo ~/Backgrounds/background$display_size.png
