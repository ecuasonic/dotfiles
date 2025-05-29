#!/usr/bin/env bash

while getopts "mfhjkl" option; do
    case $option in
        m)
            command="move"
            ;;
        f)
            command="focus"
            ;;
        h)
            command+=" left"
            ;;
        j)
            command+=" down"
            ;;
        k)
            command+=" up"
            ;;
        l)
            command+=" right"
            ;;
        *)
            ;;
    esac
done

function main() {
    i3-msg "$command"
    eval "$(xdotool getwindowfocus getwindowgeometry --shell)"
    xdotool mousemove $((X + WIDTH / 2)) $((Y + HEIGHT / 2))
}

main
