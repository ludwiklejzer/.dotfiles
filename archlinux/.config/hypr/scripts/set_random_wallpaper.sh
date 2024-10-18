#!/bin/env sh

directory=~/Pictures/wallpapers/
monitor="$(hyprctl monitors | grep Monitor | awk '{print $2}')"

if [ ! "$(pgrep -x hyprpaper)" ]; then
	hyprpaper &
	sleep 0.5
fi

if [ -d "$directory" ]; then
	random_background=$(ls -1 "$directory"/* | shuf -n 1)

	hyprctl hyprpaper unload all
	hyprctl hyprpaper preload "$random_background"
	hyprctl hyprpaper wallpaper "$monitor, $random_background"
fi
