#!/usr/bin/env bash

# Input file
input_file="$HOME/.mozilla/firefox/vall3mi9.default-release-1725378874294/prefs.js"

# Update the values in the file
sed -i \
    -e "s/^user_pref(\"zoom.maxPercent\", [0-9]\+);$/user_pref(\"zoom.maxPercent\", $1);/" \
    -e "s/^user_pref(\"zoom.minPercent\", [0-9]\+);$/user_pref(\"zoom.minPercent\", $1);/" \
    "$input_file"

killall -s SIGTERM firefox
sleep 2
firefox -P "default-release" &
