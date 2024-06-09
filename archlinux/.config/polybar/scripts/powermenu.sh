#!/usr/bin/env bash

prompt=">"
shutdown="⏻  Shutdown"
reboot="  Reboot"
suspend="  Suspend"
logout="  Logout"

confirm_command() {
	answer=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Are You Sure?")

	if [ "$answer" == "Yes" ]; then
		eval "$1"
	else
		exit 0
	fi

}

options="$suspend\n$logout\n$reboot\n$shutdown"
chosen_option="$(echo -e "$options" | rofi -dmenu -p "$prompt")"

case $chosen_option in
"$shutdown")
	confirm_command "systemctl poweroff"
	;;
"$reboot")
	confirm_command "systemctl reboot"
	;;
"$suspend")
	confirm_command "systemctl suspend"
	;;
"$logout")
	confirm_command "loginctl kill-session self"
	;;
esac
