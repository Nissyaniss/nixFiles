import QtQuick
import QtQuick.Effects

Image {
    anchors.fill: parent
    source: "file:///tmp/lock_bg_" + lockSurface.screen.name + ".png"
    fillMode: Image.PreserveAspectCrop

    layer.enabled: true
    layer.effect: MultiEffect {
        blurEnabled: true
        blurMax: 64
        blur: 0.7
    }
}
