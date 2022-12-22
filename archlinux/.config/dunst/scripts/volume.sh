#!/bin/sh

MSGTAG="volume"
VOLUME="$(pactl list sinks | grep 'Volume:' | head -n 1 | cut -d '/' -f 2 | cut -d "%" -f 1)"
MUTE="$(pactl list sinks | grep 'Mute:' | cut -d ' ' -f 2)"

if [ "$MUTE" = "yes" ]; then
	ICON="audio-volume-muted"
else
	if [ "$VOLUME" -gt 66 ]; then
		ICON="audio-volume-high"
	elif [ "$VOLUME" -gt 33 ]; then
		ICON="audio-volume-medium"
	else
		ICON="audio-volume-low"
	fi
fi

if [ "$VOLUME" -gt 100 ]; then
	BAR="$(seq -s "━" 0 33 | sed 's/[0-9]//g')"
	SPACES=""
else
	BAR="$(seq -s "━" 0 $((VOLUME / 3)) | sed 's/[0-9]//g')"
	SPACES=$(seq -s "┉" 0 $((33 - (VOLUME / 3))) | sed 's/[0-9]//g')
fi

dunstify -a "showVolume" \
	-u low \
	-i "$ICON" \
	-h string:x-dunst-stack-tag:"$MSGTAG" \
	"$BAR" "$SPACES$VOLUME%"
