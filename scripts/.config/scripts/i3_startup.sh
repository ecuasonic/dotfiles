#!/usr/bin/env bash

ERROR_LOG=~/.config/i3/error.log
SCRIPTS=~/.config/scripts
$SCRIPTS/switch_monitor.sh 2>> $ERROR_LOG
sleep 1
$SCRIPTS/rs_workspace.sh -r 2>> $ERROR_LOG
$SCRIPTS/lock_suspend.sh
