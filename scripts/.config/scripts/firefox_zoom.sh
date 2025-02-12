#!/usr/bin/env bash

#######################################
# Change the zoom of firefox before opening any firefox apps.
# Execute this script upon power up.
# Arguments:
# $1 - Zoom size out of 100.
#######################################
function firefox_size() {
	# Input file
	input_file="$HOME/.mozilla/firefox/vall3mi9.default-release-1725378874294/prefs.js"
	# Update the values in the file
	sed -i \
		-e "s/^user_pref(\"zoom.maxPercent\", [0-9]\+);$/user_pref(\"zoom.maxPercent\", $1);/" \
		-e "s/^user_pref(\"zoom.minPercent\", [0-9]\+);$/user_pref(\"zoom.minPercent\", $1);/" \
		"$input_file"
}

gpu="$(supergfxctl -g)"
if [ "$gpu" = "Hybrid" ]; then
	firefox_size "80"
elif [ "$gpu" = "Integrated" ]; then
	firefox_size "120"
fi

# killall -s SIGTERM firefox
# sleep 2
# firefox -P "default-release" &
