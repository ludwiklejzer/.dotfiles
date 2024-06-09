#!/bin/sh

network=$(nmcli -f SSID dev wifi list | sed 's/ //g;1d' - | rofi -dmenu -i -p "ESSID")

if [ "$network" != "" ]; then
	password=$(rofi -show run -dmenu -password -p "Password")
	nmcli device wifi connect "$network" password "$password"

	if [ "$?" -eq 0 ]; then
		icon="network-wireless-hotspot"
		dunstify -i "$icon" -h string:x-dunst-stack-tag:internet_connection "Wifi" "Connected to <i>$network</i>!"
	else
		icon="network-wireless-offline"
		dunstify -i "$icon" -h string:x-dunst-stack-tag:internet_connection "Wifi" "Not connected to <i>$network</i>!"
	fi
fi
