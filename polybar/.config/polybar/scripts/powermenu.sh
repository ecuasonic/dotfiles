#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="$HOME/dotfiles/polybar/.config/polybar/scripts/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -hover-select -theme $dir/powermenu.rasi"

# Options
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"
hibernate=" Hibernate"
suspend="󰒲 Sleep"
logout=" Logout"

source "/home/ecuasonic/.config/scripts/display/utils.sh"

# Confirmation
confirm_exit() {
    rofi -dmenu\
        -no-config\
        -i\
        -no-fixed-num-lines\
        -p "Are You Sure? : "\
        -theme "$dir"/confirm.rasi
    }

# Message
msg() {
    rofi -no-config -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$lock\n$logout\n$suspend\n$hibernate\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    "$shutdown")
        ans=$(confirm_exit &)
        if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
            # Prevents "server exited unexpectedly"
            rm -rf /tmp/tmux-1000/
            sleep 1
            # ~/.config/scripts/startup/rs_workspace.sh -s
            systemctl poweroff
        elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
            exit 0
        else
            msg
        fi
        ;;
    "$reboot")
        ans=$(confirm_exit &)
        if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
            # Prevents "server exited unexpectedly"
            rm -rf /tmp/tmux-1000/
            sleep 1
            # ~/.config/scripts/startup/rs_workspace.sh -s
            systemctl reboot
        elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
            exit 0
        else
            msg
        fi
        ;;
    "$lock")
        if [[ -f /usr/bin/i3lock ]]; then
            i3lock -i "$(i3lock_background)"
            sleep 2
        fi
        ;;
    "$hibernate")
        # ~/.config/scripts/startup/rs_workspace.sh -s
        ~/.config/scripts/display/laptop_monitor.sh
        sleep 1
        i3lock -i "$(i3lock_background)"
        sleep 1
        systemctl hibernate
        ;;
    "$suspend")
        i3lock -i "$(i3lock_background)"
        sleep 1
        systemctl suspend
        ;;
    "$logout")
        ans=$(confirm_exit &)
        if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
            # Prevents "server exited unexpectedly"
            rm -rf /tmp/tmux-1000/
            sleep 1
            # ~/.config/scripts/startup/rs_workspace.sh -s
            i3-msg exit
        elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
            exit 0
        else
            msg
        fi
        ;;
esac
