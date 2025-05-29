#!/usr/bin/env bash

dir="${HOME}/dotfiles/scripts/.config/scripts/rofi"
rofi_command="rofi -no-config -hover-select -theme $dir/screenshot.rasi"
rofi_command_2="rofi -no-config -theme $dir/ss_name.rasi"

# ====================================================================================

TEMP_SCREENSHOT_PATH="/tmp/temp_screenshot.png"
sel_full="󰹑 Full"
sel_window=" Window"
sel_region="󰩬 Region"

screen_size="$sel_full\n$sel_window\n$sel_region"
chosen="$(echo -e "$screen_size" | $rofi_command -p "Screenshot Size" -dmenu -selected-row 0)"
case $chosen in
    "$sel_full")
        sleep 1
        maim > $TEMP_SCREENSHOT_PATH
        ;;
    "$sel_window")
        maim -st 9999999 > $TEMP_SCREENSHOT_PATH
        ;;
    "$sel_region")
        maim --format png --select > $TEMP_SCREENSHOT_PATH
        ;;

    esac

# ====================================================================================

# Asks for the name to give to the screenshot.
# If no name, then generic name is given.
# Else, set name given by user.
function getname() {
    # ($1) refers to the destination path.
    ss_name=$(echo "" | $rofi_command_2 -dmenu | awk '{$1=$1}1' | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    if [ -z "$ss_name" ]; then
        cp $TEMP_SCREENSHOT_PATH "$1/ss_${NOW}.png"
    else
        cp $TEMP_SCREENSHOT_PATH "$1/${ss_name}.png"
    fi
}

notes=" Notes"
pictures=" Pictures"
dirpath="./ Path"
clipboard="󱓦 Only Clipboard"
cancel="CANCEL"

if [ -s $TEMP_SCREENSHOT_PATH ]; then

    location="$notes\n$pictures\n$dirpath\n$clipboard\n$cancel"
    chosen="$(echo -e "$location" | $rofi_command -p "Location" -dmenu -selected-row 0)"
    NOTES_PATH="$HOME/Documents/Obsidian_Notes/Images"
    PHOTOS_PATH="$HOME/Pictures/Screenshots"
    NOW=$(date +%d-%b-%Y-%H-%M-%S)
    case $chosen in
        "$notes")
            getname "${NOTES_PATH}"
            ;;
        "$pictures")
            getname "${PHOTOS_PATH}"
            ;;
        "$dirpath")
            path=$(echo "" | $rofi_command_2 -dmenu | awk '{$1=$1}1')
            if [ -z "$path" ] || [ ! -d "$path" ];then
                : > $TEMP_SCREENSHOT_PATH
                exit 1
            fi
            getname "${path}"
            ;;
        "$clipboard")
            cat $TEMP_SCREENSHOT_PATH | xclip -selection clipboard -t image/png
            ;;
        "$cancel")
            ;;
    esac
fi
: > $TEMP_SCREENSHOT_PATH
