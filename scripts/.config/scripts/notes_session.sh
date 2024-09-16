#!/usr/bin/env bash

NOTES=~/Documents/Obsidian_Notes/
LOCK=$NOTES.lock
TMP_KEY=/tmp/notes_session

while getopts 'se' option; do
    case $option in
        s)
            if [[ -e $TMP_KEY ]]; then
                echo "Session already started."
            else
                chmod -R u+w $NOTES
                rclone copy remote-google-drive:notes $NOTES
                sleep 0.5
                if [[ -s $LOCK ]]; then
                    cat $LOCK
                    chmod -R u-w $NOTES
                else
                    echo "$(whoami)@$(hostname) $(date)" > $LOCK
                    sleep 0.5
                    rclone sync $NOTES remote-google-drive:notes --drive-use-trash=false
                    touch $TMP_KEY
                    echo "Session started."
                fi
            fi
            ;;
        e)
            if [[ -e $TMP_KEY ]]; then
                : > $LOCK
                sleep 0.5
                rclone sync $NOTES remote-google-drive:notes --drive-use-trash=false
                chmod -R u-w $NOTES
                rm $TMP_KEY
                echo "Session ended."
            else
                echo "Session not started."
            fi
            ;;
    esac
done

