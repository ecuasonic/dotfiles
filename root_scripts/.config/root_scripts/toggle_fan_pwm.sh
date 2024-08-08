#!/bin/bash

# Function: show_help
# Description:
#   Show help menu, including parameter description message
#
# Arguments:
#   N/A
#
# Returns:
#   Outputs help menu, including parameter description message
show_help() {
    echo "Usage: $0 [-f fan] [-v]"
    # echo "-f fan                : 0 = cpu, 1 = gpu, 2 (default) = cpu/gpu."
    echo "-f fan                : 0 = cpu (default)."
    echo "-h                    : Show parameter options."
    echo "-v                    : Enable verbose mode."
}

# Function: pwm_toggle
# Description:
#   Toggles designated fan through file name (not absolute path).
#   Toggles single fan at a time.
#
# Arguments:
#   $1 : Fan to toggle through file name (not absolute path)
#
# Returns:
#   N/A
#
# Examples:
#   pwm_toggle pwm1_enable
#       Toggles fan1
#
#   pwm_toggle pwm2_enable
#       Toggles fan2
pwm_toggle() {
    base_path="/sys/devices/platform/asus-nb-wmi/hwmon/hwmon7"
    current_fan=$(cat "$base_path/$1")
    if (( $current_fan == 0 )); then
        echo 2 > "$base_path/$1"
    else
        echo 0 > "$base_path/$1"
    fi
}

if (( $(id -u) != 0 )); then
    echo "Please run $0 as root" >&2
    exit 1
fi

fan_option=-1
verbose=0

while getopts "hf:v" option
do
    case $option in
        # It seems as though gpu fan doesn't work right now, so I'm going to force only cpu fan
        # Here, I'm going to make it possible to extend it for gpu fan in the future
        # echo: write error: Input/output error
        f)
            if [ -n "$OPTARG" ]; then
                fan_option=$OPTARG
            fi
            ;;
        v)
            verbose=1
            ;;
        h)
            show_help
            exit 0
            ;;
        \?)
            echo "Invalid option: -$option" >&2
            show_help
            exit 1
            ;;
    esac
done

if (( $fan_option == -1 )); then
    fan_option=0
# elif (( $fan_option != 0 )) && (( $fan_option != 1 )) && (( $fan_option != 2 )); then
elif (( $fan_option != 0 )); then
    show_help
    exit 1
fi

case $fan_option in
    0)
        pwm_toggle pwm1_enable
        ;;
    # 1)
    #     pwm_toggle pwm2_enable
    #     ;;
    # 2)
    #     pwm_toggle pwm1_enable
    #     pwm_toggle pwm2_enable
    #     ;;
    \?)
        echo "Internal Error: L12"
        ;;
esac
