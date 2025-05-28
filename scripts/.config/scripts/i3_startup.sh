#!/usr/bin/env bash

ERROR_LOG=~/.config/i3/error.log
SCRIPTS=~/.config/scripts

xrandr --output "HDMI-1" --off
xrandr --output "HDMI-1-1" --off
xrandr --output "HDMI-2" --off
sleep 1

$SCRIPTS/display/switch_monitor.sh 2>> $ERROR_LOG
sleep 1

$SCRIPTS/firefox_zoom.sh 2>> $ERROR_LOG
# $SCRIPTS/rs_workspace.sh -r 2>> $ERROR_LOG
sleep 1

$SCRIPTS/display/resize_floating.sh 2>> $ERROR_LOG
sleep 1

i3-msg restart
