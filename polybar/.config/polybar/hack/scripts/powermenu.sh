#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="~/.config/polybar/hack/scripts/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -theme $dir/powermenu.rasi"

# Options
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"
hibernate=" Hibernate"
suspend="󰒲 Sleep"
logout=" Logout"

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-no-config\
        -i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme $dir/confirm.rasi
}

# Message
msg() {
	rofi -no-config -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$lock\n$logout\n$suspend\n$hibernate\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl poweroff
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $reboot)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl reboot
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $lock)
		if [[ -f /usr/bin/i3lock ]]; then
            i3lock -i $(~/.config/custom_scripts/i3lock_background.sh)
            sleep 2
		elif [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		fi
        ;;
    $hibernate)
        i3-save-tree --workspace 1 > ~/.i3/workspace-1.json
        i3-save-tree --workspace 2 > ~/.i3/workspace-2.json
        i3-save-tree --workspace 3 > ~/.i3/workspace-3.json
        sleep 1

        ~/.config/custom_scripts/laptop_monitor.sh
        sleep 2
        i3lock -i $(~/.config/custom_scripts/i3lock_background.sh)
        sleep 2
        systemctl hibernate
        ;;
    $suspend)
        i3lock -i $(~/.config/custom_scripts/i3lock_background.sh)
        sleep 2
        systemctl suspend
        ;;
    $logout)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
            i3-save-tree --workspace 1 > ~/.i3/workspace-1.json
            i3-save-tree --workspace 2 > ~/.i3/workspace-2.json
            i3-save-tree --workspace 3 > ~/.i3/workspace-3.json
            sleep 1

			if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
				i3-msg exit
			fi
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
esac
