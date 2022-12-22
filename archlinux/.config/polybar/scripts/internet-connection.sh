#!/bin/sh

NETWORK=$(nmcli -f SSID dev wifi list | sed 's/ //g;1d' - | rofi -dmenu -i -p "ESSID")

if [ "$NETWORK" != "" ]; then
	PASSWORD=$(rofi -show run -dmenu -password -p "Password")
	nmcli device wifi connect "$NETWORK" password "$PASSWORD"

	if "$?" -eq 0; then
		ICON="network-wireless-hotspot"
		dunstify -i "$ICON" -wireless -h string:x-dunst-stack-tag:internet_connection "Wifi" "Connected to <i>$NETWORK</i>!"
	else
		ICON="network-wireless-offline"
		dunstify -i "$ICON" -h string:x-dunst-stack-tag:internet_connection "Wifi" "Not connected to <i>$NETWORK</i>!"
	fi
fi
