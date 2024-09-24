#!/usr/bin/env bash

NOTES=~/Documents/Obsidian_Notes/
LOCK=$NOTES.lock
TMP_KEY=~/Documents/.notes_session

while getopts 'se' option; do
    case $option in
        s)
            if [[ -e $TMP_KEY ]]; then
                echo "Session already started."
            else
                chmod -R u+w $NOTES
                echo ""
                echo "======================="
                echo "Pulling google drive..."
                echo "======================="
                echo ""
                rclone sync remote-google-drive:notes $NOTES -v
                sleep 0.5
                if [[ -s $LOCK ]]; then
                    echo "================================="
                    echo "Other computer has notes session:"
                    cat $LOCK
                    echo "================================="
                    echo ""
                    chmod -R u-w $NOTES
                else
                    echo "$(whoami)@$(hostname) $(date)" > $LOCK
                    sleep 0.5
                    echo "=================================="
                    echo "Pushing google drive with .lock..."
                    echo "=================================="
                    echo ""
                    rclone sync $NOTES remote-google-drive:notes --drive-use-trash=false -v
                    touch $TMP_KEY
                    echo "================"
                    echo "Session started."
                    echo "================"
                    echo ""
                fi
            fi
            ;;
        e)
            if [[ -e $TMP_KEY ]]; then
                : > $LOCK
                sleep 0.5
                echo ""
                echo "======================================"
                echo "Pushing google drive with new notes..."
                echo "======================================"
                echo ""
                rclone sync $NOTES remote-google-drive:notes --drive-use-trash=false -v
                chmod -R u-w $NOTES
                rm $TMP_KEY
                echo "=============="
                echo "Session ended."
                echo "=============="
                echo ""
            else
                echo ""
                echo "===================="
                echo "Session not started."
                echo "===================="
                echo ""
            fi
            ;;
    esac
done

