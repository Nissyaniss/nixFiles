import QtQuick
import QtQuick.Effects

Image {
    anchors.fill: parent
    source: "file:///tmp/lock_bg_" + lockSurface.screen.name + ".png"
    fillMode: Image.PreserveAspectCrop
}
