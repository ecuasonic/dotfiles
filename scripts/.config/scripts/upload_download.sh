#!/usr/bin/env bash

dir="$HOME/dotfiles/scripts/.config/scripts/rofi"
rofi_command="rofi -no-config -hover-select -theme $dir/screenshot.rasi"

notes="Upload Notes"
pictures="Upload Pictures"
goodnotes="Download Goodnotes"

prompt="$notes\n$pictures\n$goodnotes"
chosen="$(echo -e "$prompt" | $rofi_command -p "Data Transfer" -dmenu -selected-row 0)"
case $chosen in
    $notes)
        rclone sync ~/Documents/Obsidian_Notes remote-google-drive:notes --drive-use-trash=false
        ;;
    $pictures)
        rclone sync ~/Pictures remote-google-drive:photos --drive-use-trash=false
        ;;
    $goodnotes)
        rclone copy remote-google-drive:GN_Rough_Images ~/Documents/Goodnotes
        for i in $(ls ~/Documents/Goodnotes); do
            magick -density 300 ~/Documents/Goodnotes/$i ~/Documents/Obsidian_Notes/Rough_Images/${i%.pdf}.png
        done
        ;;
esac
