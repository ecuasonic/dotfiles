#!/usr/bin/env bash
source "${HOME}/.config/scripts/display/utils.sh"

DIR="${HOME}/dotfiles/polybar/.config/polybar/scripts/rofi"
ROFI_CMD="rofi -no-config -hover-select -theme $DIR/powermenu.rasi"

declare -A ACTIONS=(
    [" Shutdown"]="poweroff"
    [" Restart"]="reboot"
    [" Lock"]="lock"
    [" Hibernate"]="hibernate"
    ["󰒲 Sleep"]="suspend"
    [" Logout"]="logout"
)

# =============================================================================

function rofi_confirm_exit() {
    rofi -dmenu -no-config -i -no-fixed-num-lines -p "Are You Sure? : " -theme "$DIR"/confirm.rasi
}
function rofi_msg() {
    rofi -no-config -theme "$DIR/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# =============================================================================

function in_array() {
    local val=$1; shift
    for item; do
        [ "$item" = "$val" ] && return 0
    done
    return 1
}

# =============================================================================

function confirm_then_action() {
    local action=$1
    local ans
    ans=$(rofi_confirm_exit &)
    case "${ans,,}" in
        y|yes)
            rm -rf /tmp/tmux-1000/
            sleep 1
            systemctl "$action"
            ;;
        n|no)
            exit 0
            ;;
        *)
            rofi_msg
            ;;
    esac
}

function lock_screen() {
    if [[ -f /usr/bin/i3lock ]]; then
        i3lock -i "$(i3lock_background)"
        sleep 1
    fi
}

function main() {
    # Variable passed to rofi
    options=$(printf "%s\n" "${!ACTIONS[@]}")
    uptime=$(uptime -p | sed -e 's/up //g')
    chosen="$(echo -e "$options" | $ROFI_CMD -p "Uptime: $uptime" -dmenu -selected-row 0)"

    case $chosen in
        " Lock")
            lock_screen
            ;;
        " Hibernate")
            ~/.config/scripts/display/laptop_monitor.sh
            lock_screen
            systemctl hibernate
            ;;
        "󰒲 Sleep")
            lock_screen
            systemctl suspend
            ;;
        *)
            if [[ -n "${ACTIONS[$chosen]}" ]]; then
                confirm_then_action "${ACTIONS[$chosen]}"
            fi
            ;;
    esac
}

main
