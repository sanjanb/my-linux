#!/bin/bash
# Toggle Waybar visibility
killall -SIGUSR1 waybar

# Toggle Hyprland blur/animations for performance
hyprctl keyword decoration:blur:enabled 0
hyprctl keyword animations:enabled 0

notify-send "Stream Mode" "UI elements hidden and effects disabled for recording."
