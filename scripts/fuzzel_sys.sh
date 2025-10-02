#!/usr/bin/env bash



NOTIFYCMD=notify-send
MENUCMD=fuzzel


lock() {
	loginctl lock-session
}


kill() {
	PID=$(ps -u $USER -o pid,comm,%cpu,%mem | $MENUCMD --dmenu --width 50 --lines 15 --prompt "Kill: ") || exit 0
	echo "$PID" | awk '{print $1}' | xargs -r kill && $NOTIFYCMD "Process killed."
}


reboot() {
	systemctl reboot -i
}


shutdown() {
	shutdown now
}


menu() {
	CHOICE=$(printf "󰯆  Kill Process\n󰌾  Lock\n󰜉  Reboot\n󰐥  Shutdown" | $MENUCMD --dmenu --width 30 --lines 4 )
	case "$CHOICE" in
		*Kill*) kill ;;
		*Lock*) lock ;;
		*Reboot*) reboot ;;
		*Shutdown*) shutdown ;;
	esac
}

menu