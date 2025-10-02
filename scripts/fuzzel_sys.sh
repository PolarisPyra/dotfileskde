#!/usr/bin/env bash

case "$(printf "lock\nkill\nzzz\nreboot\nshutdown" | fuzzel --dmenu --width 30 --lines 5 --hide-prompt)" in
	lock) loginctl lock-session ;;
	kill) ps -u $USER -o pid,comm,%cpu,%mem | fuzzel --dmenu --width 30 --lines 10 --prompt "Kill: " | awk '{print $1}' | xargs -r kill ;;
	reboot) systemctl reboot -i ;;
	shutdown) shutdown now ;;
	*) exit 1 ;;
esac