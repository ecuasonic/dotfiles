#!/usr/bin/env bash

# ============================================================

DIR="${HOME}/dotfiles/scripts/.config/scripts/rofi"
ROFI_BASE="rofi -no-config"
ROFI_MENU="$ROFI_BASE -hover-select -theme $DIR/screenshot.rasi"
ROFI_NAME="$ROFI_BASE -no-config -theme $DIR/ss_name.rasi"
ROFI_PATH="$ROFI_BASE -no-config -theme $DIR/ss_path.rasi"

TEMP_SCREENSHOT="/tmp/temp_screenshot.png"
NOTES_PATH="${HOME}/Documents/Obsidian_Notes/Images"
PHOTOS_PATH="${HOME}/Pictures/Screenshots"
NOW=$(date +%d-%b-%Y-%H-%M-%S)

# ============================================================

SEL_FULL="󰹑 Full"
SEL_WINDOW=" Window"
SEL_REGION="󰩬 Region"

OPT_NOTES=" Notes"
OPT_PICTURES=" Pictures"
OPT_CUSTOM_DIR="./ Path"
OPT_CLIPBOARD="󱓦 Only Clipboard"

# ============================================================

function select_image_size() {
    screen_size="$SEL_FULL\n$SEL_WINDOW\n$SEL_REGION"
    chosen="$(echo -e "$screen_size" | $ROFI_MENU -p "Screenshot Size" -dmenu -selected-row 0)"
    case $chosen in
        "$SEL_FULL")
            sleep 1
            maim > $TEMP_SCREENSHOT
            ;;
        "$SEL_WINDOW")
            maim -st 9999999 > $TEMP_SCREENSHOT
            ;;
        "$SEL_REGION")
            maim --format png --select > $TEMP_SCREENSHOT
            ;;
    esac
}

# ============================================================

function get_image_name() {
    # ($1) refers to the destination path.
    ss_name=$(echo "" | $ROFI_NAME -dmenu | awk '{$1=$1}1' | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    if [ -z "$ss_name" ]; then
        cp $TEMP_SCREENSHOT "$1/ss_${NOW}.png"
    else
        cp $TEMP_SCREENSHOT "$1/${ss_name}.png"
    fi
}

function select_image_destination() {
    if [ -s $TEMP_SCREENSHOT ]; then

        location="$OPT_NOTES\n$OPT_PICTURES\n$OPT_CUSTOM_DIR\n$OPT_CLIPBOARD"
        chosen="$(echo -e "$location" | $ROFI_MENU -p "Location" -dmenu -selected-row 0)"
        case $chosen in
            "$OPT_NOTES")
                get_image_name "${NOTES_PATH}"
                ;;
            "$OPT_PICTURES")
                get_image_name "${PHOTOS_PATH}"
                ;;
            "$OPT_CUSTOM_DIR")
                path=$(echo "" | $ROFI_PATH -dmenu | awk '{$1=$1}1')
                if [ -z "$path" ] || [ ! -d "$path" ];then
                    : > $TEMP_SCREENSHOT
                    exit 1
                fi
                get_image_name "${path}"
                ;;
            "$OPT_CLIPBOARD")
                cat $TEMP_SCREENSHOT | xclip -selection clipboard -t image/png
                ;;
        esac
    fi
    : > $TEMP_SCREENSHOT
}

# ============================================================

function main() {
    select_image_size
    select_image_destination
}

main
