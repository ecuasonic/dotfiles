#!/bin/bash

ERROR_LOG=~/.config/i3/error.log
SCRIPTS=~/.config/custom_scripts

$SCRIPTS/restore_workspaces.sh 2>> $ERROR_LOG
sleep 1.5
$SCRIPTS/switch_monitor.sh 2>> $ERROR_LOG
sleep 1
$SCRIPTS/start_i3_program.sh "picom" 2>> $ERROR_LOG
$SCRIPTS/start_i3_program.sh "nitrogen" "--restore" 2>> $ERROR_LOG
