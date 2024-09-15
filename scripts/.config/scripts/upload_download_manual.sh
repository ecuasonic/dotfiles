#!/usr/bin/env bash

function err_msg() {
    echo "Only include one of the following options"
    echo "n) Notes"
    echo "p) Photos"
}


# Parse options
while getopts "d:u:" option; do
    case $option in
        # Download / Pull
        d)
            case $OPTARG in
                n)
                    # Pull n
                    rclone copy remote-google-drive:notes ~/Documents/Obsidian_Notes
                    ;;
                g)
                    # Pull g
                    rclone copy remote-google-drive:GN_Rough_Images
                    ;;
                *)
                    err_msg
                    exit 1
                    ;;
            esac
            ;;
        # Upload / Push
        u)
            case $OPTARG in
                n)
                    # Push n
                    rclone sync ~/Documents/Obsidian_Notes remote-google-drive:notes --drive-use-trash=false
                    echo "Don't forget to pull on MBP!"
                    ;;
                p|s)
                    # Push p (Separate folder)
                    rclone sync ~/Pictures remote-google-drive:photos_mbp2012 --drive-use-trash=false
                    echo "Don't forget to pull on MBP!"
                    ;;
                *)
                    err_msg
                    exit 1
                    ;;
            esac
            ;;
    esac

done

