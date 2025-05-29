#!/usr/bin/env bash

ERROR_LOG="${HOME}/.config/scripts/i3_resurrect_error.log"
: > "$ERROR_LOG"

show_usage() {
    echo "Usage: $0 [-r (restore) | -s (save)]"
    exit 1
}

run_command() {
    local action=$1
    local delay=$2
    for workspace in {1..4}; do
		i3_resurrect=$(which i3-resurrect 2>/dev/null)
		if [ -z "$i3_resurrect" ]; then
			echo "Error: i3-resurrect not found. Exiting function."
			return 1
		fi
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
