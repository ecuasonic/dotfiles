#!/usr/bin/bash

ERROR_LOG=~/.config/i3/error.log
SCRIPTS=~/.config/scripts

$SCRIPTS/start_i3_program.sh "picom" 2>> $ERROR_LOG
$SCRIPTS/start_i3_program.sh "nitrogen" "--restore" 2>> $ERROR_LOG
sleep 0.5
$SCRIPTS/switch_monitor.sh 2>> $ERROR_LOG
$SCRIPTS/rs_workspace.sh -r 2>> $ERROR_LOG

rclone sync ~/Documents/Obsidian-Notes remote-google-drive:notes --drive-use-trash=false
$SCRIPTS/lock_suspend.sh
