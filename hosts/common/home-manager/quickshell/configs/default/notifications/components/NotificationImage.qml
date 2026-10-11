import QtQuick
import Quickshell
import QtCore

Image {
    required property string icon
    required property string image

    source: image
    height: 60
    width: 60
    fillMode: Image.PreserveAspectFit
    Image {
        source: Quickshell.iconPath(modelData.appIcon)
        height: 25
        width: 25
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        fillMode: Image.PreserveAspectFit
    }
}
