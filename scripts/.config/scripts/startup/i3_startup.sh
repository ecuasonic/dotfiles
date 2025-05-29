#!/usr/bin/env bash

ERROR_LOG=~/.config/i3/error.log
SCRIPTS=~/.config/scripts

$SCRIPTS/startup/machine_specific.sh 2>> $ERROR_LOG

xrandr --output "HDMI-1" --off
xrandr --output "HDMI-1-1" --off
xrandr --output "HDMI-2" --off
sleep 1

$SCRIPTS/display/switch_monitor.sh 2>> $ERROR_LOG
$SCRIPTS/startup/firefox_zoom.sh 2>> $ERROR_LOG

i3-msg restart
