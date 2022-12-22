#!/bin/sh

MSGTAG="volume"
MAX_BRIGHTNESS="$(cat /sys/class/backlight/intel_backlight/max_brightness)"
CURRENT_BRIGHTNESS="$(cat /sys/class/backlight/intel_backlight/brightness)"
BRIGHTNESS="$(((CURRENT_BRIGHTNESS * 100) / MAX_BRIGHTNESS))"

BAR="$(seq -s "━" 0 $((BRIGHTNESS / 3)) | sed 's/[0-9]//g')"
SPACES=$(seq -s "┉" 0 $((33 - (BRIGHTNESS / 3))) | sed 's/[0-9]//g')

if [ "$BRIGHTNESS" -gt 66 ]; then
	ICON="display-brightness-symbolic"
elif [ "$BRIGHTNESS" -gt 33 ]; then
	ICON="display-brightness-medium-symbolic"
elif [ "$BRIGHTNESS" -gt 1 ]; then
	ICON="display-brightness-low-symbolic"
else
	ICON="display-brightness-off-symbolic"
fi

dunstify -a "showVolume" \
	-u low \
	-i "$ICON" \
	-h string:x-dunst-stack-tag:"$MSGTAG" \
	"$BAR" "$SPACES $BRIGHTNESS%"
