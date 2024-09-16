#!/usr/bin/env bash

NOTES=~/Documents/Obsidian_Notes/
LOCK=$NOTES.lock
TMP_KEY=/tmp/notes_session

while getopts 'se' option; do
    case $option in
        s)
            rclone copy remote-google-drive:notes $NOTES
            if [[ -e $LOCK ]]; then
                cat $LOCK
            else
                chmod -R u+w $NOTES
                touch $LOCK
                echo "$(whoami)@$(hostname)" > $LOCK
                rclone sync $NOTES remote-google-drive:notes --drive-use-trash=false
                touch $TMP_KEY
                echo "Session started."
            fi
            ;;
        e)
            if [[ -e $TMP_KEY ]]; then
                rm $LOCK
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

