#!/usr/bin/sh

MSGTAG="redshift"

show_dunst() {
	dunstify -a "redshiftToggle" \
		-u low \
		-i "$ICON" \
		-h string:x-dunst-stack-tag:"$MSGTAG" \
		"Redshift" "$MSG"
}

if [ "$(pidof redshift >/dev/null && echo $?)" = "0" ] && [ "$1" = "--toggle" ]; then
	MSG="Off"
	ICON="redshift-status-off"
	killall redshift &
	show_dunst
elif [ "$1" = "--toggle" ]; then
	redshift &
	MSG="On"
	ICON="redshift-status-on"
	show_dunst
fi

if [ "$(pidof redshift >/dev/null && echo $?)" = "0" ] && [ "$1" = "" ]; then
	echo "ON"
elif [ "$1" = "" ]; then
	echo "OFF"
fi
