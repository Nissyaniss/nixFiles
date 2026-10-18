import QtQuick
import Quickshell

Image {
    id: root
    required property var modelData

    source: modelData.image
    height: 60
    width: 60
    fillMode: Image.PreserveAspectFit
    Image {
        source: Quickshell.iconPath(root.modelData.appIcon)
        height: 25
        width: 25
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        fillMode: Image.PreserveAspectFit
    }
}
