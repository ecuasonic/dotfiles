#!/usr/bin/env bash

# TODO: Implement checking system where if checks or transferred is not 100% then don't proceed.
# If nothing transferred, then -% for transferred.

function msg() {
    if (( $# == 2 )); then
        input_msg=$1
        device_name=$(cat $2 | awk '{ print $1 }')
        date=$(cat $2 | sed 's/^[^ ]* //')
        length=$(( ${#input_msg} > ${#date} ? ${#input_msg} : ${#date}))
    else
        length=${#1}
    fi

    for (( i=0; i < length; i++ )); do
        border+="-"
    done

    echo ""
    echo $border
    echo $1
    if (( $# == 2 )); then
        echo ""
        printf "    "
        echo $device_name
        printf "    "
        echo $date
        echo ""
    fi
    echo $border
    echo ""

    border=""
}

NOTES=~/Documents/Obsidian_Notes/
DRIVE=remote-google-drive:notes
LOCK=$NOTES.lock
TMP_KEY=~/Documents/.notes_session
TEMP=/tmp/transfer_progress

SUB='s/([0-9]{1,3}%)/\x1b[1;36m\1\x1b[m/g'

while getopts 'se' option; do
    case $option in
        s)
            if [[ -e $TMP_KEY ]]; then
                msg "Session already started."
            else
                chmod -R u+w $NOTES
                msg "Pulling google drive..."
                rclone sync $DRIVE $NOTES --track-renames --local-case-sensitive --progress
                sleep 0.5
                if [[ -s $LOCK ]]; then
                    msg "Other computer has notes session:" $LOCK
                    chmod -R u-w $NOTES
                else
                    echo "$(whoami)@$(hostname) $(date +'%a %D %r')" > $LOCK
                    sleep 0.5
                    msg "Pushing google drive with .lock..."
                    rclone sync $NOTES $DRIVE --drive-use-trash=false --progress
                    touch $TMP_KEY
                    msg "Session started."
                fi
            fi
            ;;
        e)
            if [[ -e $TMP_KEY ]]; then
                : > $LOCK
                sleep 0.5
                msg "Pushing google drive with new notes..."
                rclone sync $NOTES $DRIVE --drive-use-trash=false --progress --track-renames --local-case-sensitive
                chmod -R u-w $NOTES
                rm $TMP_KEY
                msg "Session ended."
            else
                msg "Session not started."
            fi
            ;;
    esac
done

