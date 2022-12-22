#!/usr/bin/env bash

prompt="select"

# Options
shutdown="⏻  Shutdown"
reboot="  Reboot"
suspend="  Suspend"
logout="  Logout"

# Confirmation
confirm_exit() {
	echo -e "Yes\nNo" |
		rofi -dmenu -i -p "Are You Sure?"
}

# Variable passed to rofi
options="$suspend\n$logout\n$reboot\n$shutdown"

# Variable passed to rofi
chosen="$(echo -e "$options" | rofi -dmenu -p "$prompt")"

case $chosen in
"$shutdown")
	answer=$(confirm_exit &)

	if [[ $answer == "Yes" ]]; then
		systemctl poweroff
	else
		exit 0
	fi
	;;

"$reboot")
	answer=$(confirm_exit &)

	if [[ $answer == "Yes" ]]; then
		systemctl reboot
	else
		exit 0
	fi
	;;

"$suspend")
	answer=$(confirm_exit &)

	if [[ $answer == "Yes" ]]; then
		systemctl suspend
	else
		exit 0
	fi
	;;
"$logout")
	answer=$(confirm_exit &)

	if [[ $answer == "Yes" ]]; then
		loginctl kill-session self
	else
		exit 0
	fi
	;;
esac
