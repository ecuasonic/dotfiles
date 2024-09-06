#!/usr/bin/bash

# Ex: ./start_i3_program.sh "xcape" "-e 'Control_L=Escape' -t 175"
# Please test before using, minimal edge cases considered. Script made in a few minutes.

if (( $# == 0 )); then
    echo "You must include the program_name!" >&2
    exit 1
elif (( $# > 2 )); then
    echo "You must only inlude the program_name and program_arguments!" >&2
    exit 1
fi

program_name=$1
program_arguments=$2

# Get list of program instances currently running
program=$(ps aux | awk -v input="$program_name" ' $11 == input { print $11 }')

# Restarts program if already running, else start program
if [ -n "$program" ]; then
    killall $program_name
    sleep 0.1
fi

if (( $# == 1 )); then
    $program_name
else
    eval "$program_name $program_arguments"
fi
