#!/usr/bin/env bash

STATUS="$(playerctl status 2>/dev/null)"

[ -z "$STATUS" ] && echo "" && exit 0

ARTIST="$(playerctl metadata artist 2>/dev/null)"
TITLE="$(playerctl metadata title 2>/dev/null)"

[ -z "$TITLE" ] && echo "" && exit 0

case "$STATUS" in
    Playing) ICON="󰎆" ;;
    Paused) ICON="󰏤" ;;
    *) ICON="󰎆" ;;
esac

if [ -n "$ARTIST" ]; then
    echo "$ICON $ARTIST - $TITLE"
else
    echo "$ICON $TITLE"
fi
