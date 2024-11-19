#!/usr/bin/env bash

display_size=$(xrandr --listmonitors | tail -1 | awk '{print $3}' | awk -F'[/x]' '{print $1"x"$3}')
echo "${HOME}/Backgrounds/background${display_size}.png"
