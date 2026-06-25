#!/bin/bash

if pgrep -f "[L]auncher.qml" >/dev/null 2>&1; then
    pkill -f "[L]auncher.qml"
else
    exec qs -p ~/.nixFiles/config/home-manager/shell/quickshell/configs/default/launcher/Launcher.qml
fi