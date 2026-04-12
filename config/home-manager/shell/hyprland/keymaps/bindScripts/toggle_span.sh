#!/bin/bash

state=$(hyprctl activewindow -j | jq -r '.floating')

if [[ "$state" == "true" ]]; then
    hyprctl dispatch togglefloating active
else
    hyprctl --batch "dispatch togglefloating active ; dispatch moveactive exact -1920 0 ; dispatch resizeactive exact 5760 1080"
fi