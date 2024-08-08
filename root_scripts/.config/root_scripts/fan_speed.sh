#!/bin/bash

# Function: show_help
# Description:
#   Show help menu, including parameter description message
#
# Arguments:
#   N/A
#
# Returns:
#   Output help menu, including parameter description message
show_help() {
    echo "Usage: $0 -f <fan> -s <fan-speed> [-v]"
    # echo "-f fan                : 0 = cpu, 1 = gpu, 2 (default) = cpu/gpu."
    echo "-f fan                : 0 = cpu (default)."
    echo "-s fan-speed          : Numeric value between 0 and 4000 (RPM), inclusive."
    echo "-h                    : Show parameter options."
    echo "-v                    : Enable verbose mode."
}


if (( $(id -u) != 0 )); then
    echo "Please run $0 as root" >&2
    exit 1
fi

fan_option=-1
fan_speed=-1
verbose=0

# set fan speed for one fan at a time
# Allow no option to set fan at same speeds
while getopts "hf:s:v" option
do
    case $option in
        h)
            show_help
            exit 0
            ;;
        f)
            if [[ -n "$OPTARG" ]] && [[ "$OPTARG" -ge 0 ]] && [[ "$OPTARG" -le 1 ]]; then
                fan_option=$OPTARG
            else
                echo "Please enter specific fan, either 0 (CPU) or 1 (GPU)" >&2
                exit 1
            fi
            ;;
        s)
            if [[ -n "$OPTARG" ]] && [[ "$OPTARG" -ge 0 ]] && [[ "$OPTARG" -le 4000 ]]; then
                fan_speed=$OPTARG
            else
                echo "Please enter a fan speed, between 0 and 4000 (RPM)" >&2
                exit 1
            fi
            ;;
        v)
            verbose=1;
            ;;
    esac
done

# Should constantly read fan speed from a file and not from direct input
while true; do
    ./toggle_fan_pwm "$fan_option"

    if (( verbose )); then
        echo "Verbose: Fan $fan_option is being adjusted."
    fi

    sleep 0.1

    # trap cleanup SIGINT
done
