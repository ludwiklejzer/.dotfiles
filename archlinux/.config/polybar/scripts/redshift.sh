#!/usr/bin/sh

msg_tag="redshift"
redshift_status=$(pidof redshift >/dev/null && echo $?)

show_dunst() {
	dunstify -a "redshiftToggle" \
		-u low \
		-i "$icon" \
		-h string:x-dunst-stack-tag:"$msg_tag" \
		"Redshift" "$msg"
}

if [ "$redshift_status" = "0" ]; then
	echo "ON"
elif [ "$1" = "" ]; then
	echo "OFF"
fi

if [ "$redshift_status" = "0" ] && [ "$1" = "--toggle" ]; then
	msg="Off"
	icon="redshift-status-off"
	killall redshift &
	show_dunst
elif [ "$1" = "--toggle" ]; then
	redshift &
	msg="On"
	icon="redshift-status-on"
	show_dunst
fi
