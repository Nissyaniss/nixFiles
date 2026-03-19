#!/usr/bin/env nu

let state = (hyprctl activewindow -j | from json | get floating)

if $state {
    hyprctl dispatch togglefloating active
} else {
    hyprctl --batch "dispatch togglefloating active ; dispatch moveactive exact -1920 0 ; dispatch resizeactive exact 5760 1080"
}