#!/usr/bin/env bash

ERROR_LOG=/home/ecuas/.config/scripts/i3_resurrect_error.log
: > $ERROR_LOG

show_usage() {
        echo "Usage: $0 [-r (restore) | -s (save)]"
        exit 1
}

run_command() {
        local action=$1
        local delay=$2
        for workspace in {1..4}; do
                python -m i3_resurrect.main "$action" -w "$workspace" >> "$ERROR_LOG" 2>&1
                sleep "$delay"
        done
}

main() {
        [[ $# -ne 1 ]] && show_usage

        while getopts "rs" option; do
                case $option in
                        r)
                                run_command "restore" 1
                                i3-msg 'workspace 1' --quiet
                                ;;
                        s)
                                run_command "save" 0.5
                                ;;
                        *)
                                show_usage
                                ;;
                esac
        done
}

main "$@"
