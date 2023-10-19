#!/bin/sh

success() {
	notify-send "Recording" "Saved Successufully!"
	polybar-msg action "#recaudio.hook.2"
	exit 0
}

error() {
	polybar-msg action "#recaudio.hook.2"
	notify-send "Error" "Something went wrong!"
	exit 1
}

if [ ! "$(pidof ffmpeg)" ]; then
	NAME="$(date +%Y-%m-%d_%H:%M).mp3"
	LOCATION=$(zenity --file-selection --save --filename="$NAME")

	if [ "$LOCATION" != "" ]; then
		polybar-msg action "#recaudio.hook.0"
		ffmpeg -f pulse -y -loglevel quiet -i default "$LOCATION"

		FFMPEG_EXIT_CODE="$?"
		[ "$FFMPEG_EXIT_CODE" -eq 1 ] && error

		trap success 0
	fi
else
	pkill ffmpeg
fi
