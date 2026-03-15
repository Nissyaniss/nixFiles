#!/usr/bin/env nu

let status = (do -i { pgrep -f "[L]auncher.qml" } | complete)

if $status.exit_code == 0 {
    pkill -f "[L]auncher.qml"
} else {
    exec qs -p ~/.nixFiles/config/home-manager/shell/quickshell/configs/default/launcher/Launcher.qml
}