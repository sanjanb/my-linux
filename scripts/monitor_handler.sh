#!/bin/bash

# Define your monitor names (check with 'hyprctl monitors')
LAPTOP="eDP-1"
EXTERNAL="HDMI-A-1" # or DP-1, check your port!

handle() {
  case $1 in
    monitoradded*)
      # When external monitor is plugged in:
      # Laptop screen stays at 1.25 scale, External monitor goes to the LEFT at 1.0 scale
      hyprctl keyword monitor "$EXTERNAL, preferred, -1920x0, 1"
      notify-send "Display Connected" "Switching to Dual-Monitor Work Mode"
      ;;
    monitorremoved*)
      # When unplugged: Reset laptop screen to center
      hyprctl keyword monitor "$LAPTOP, preferred, 0x0, 1.25"
      notify-send "Display Removed" "Returning to Laptop Mode"
      ;;
  esac
}

# Listen to Hyprland events
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
