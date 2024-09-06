#!/usr/bin/bash

ERROR_LOG=/home/ecuas/.config/scripts/i3_resurrect_error.log
echo "" > $ERROR_LOG 2>&1

main() {

    if (( $# != 1 )); then
        echo "You must include either -r (restore) or -s (save)!"
        exit 1
    fi

    while getopts "rs" option; do
        case $option in
            r)
                for (( i=1; i<5; i++ )); do
                    python -m i3_resurrect.main restore -w $i >> $ERROR_LOG 2>&1
                    sleep 1
                done
                i3-msg 'workspace 1' --quiet
                ;;
            s)
                for (( i=1; i<5; i++ )); do
                    python -m i3_resurrect.main save -w $i >> $ERROR_LOG 2>&1
                    sleep 0.5
                done
                ;;
        esac
    done
}

main $1
