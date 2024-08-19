#!/bin/bash

ERROR_LOG=/home/ecuas/.config/custom_scripts/i3_resurrect_error.log
echo "" > $ERROR_LOG 2>&1

for ((i=1; i<7; i++)); do
    python -m i3_resurrect.main restore -w $i >> $ERROR_LOG 2>&1
    sleep 0.3
done

i3-msg 'workspace 1' --quiet

