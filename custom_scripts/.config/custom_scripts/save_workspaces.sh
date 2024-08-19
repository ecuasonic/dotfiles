#!/bin/bash

ERROR_LOG=/home/ecuas/.config/custom_scripts/i3_resurrect_error.log
echo "" > $ERROR_LOG 2>&1

for (( i=1; i<7; i++ )); do
    python -m i3_resurrect.main save -w $i >> $ERROR_LOG 2>&1
done

# current_workspace=$(i3-msg -t get_outputs | jq -r '.[].current_workspace | select(. != null)')
#
# echo "Starting..."
# for (( i=1; i < 7; i++ )); do
#     echo "Saving workspace $i"
#     i3-msg "workspace ${i}; append_layout /home/ecuas/.i3/workspace-${i}.json"
#     sleep 1
# done
#
# i3-msg "workspace ${current_workspace}" --quiet
