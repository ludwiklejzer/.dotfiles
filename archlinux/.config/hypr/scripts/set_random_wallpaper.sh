#!/bin/env sh

directory=~/Pictures/wallpapers/
monitors="$(hyprctl monitors | grep Monitor | awk '{print $2}')"

if [ ! "$(pgrep -x hyprpaper)" ]; then
	hyprpaper &
	sleep 0.5
fi

if [ -d "$directory" ]; then
	random_background=$(find "$directory"/* | shuf -n 1)

	hyprctl hyprpaper unload all
	hyprctl hyprpaper preload "$random_background"

	for monitor in $monitors; do
		hyprctl hyprpaper wallpaper "$monitor, $random_background"
	done
fi
