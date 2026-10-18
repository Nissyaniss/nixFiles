import QtQuick
import Quickshell

Image {
    property string screen_name

    cache: false
    anchors.fill: parent
    source: screen_name ? Quickshell.env("XDG_RUNTIME_DIR") + "/lock_bg_" + screen_name + ".png" : ""
    fillMode: Image.PreserveAspectCrop
}
