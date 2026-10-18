import QtQuick
import "./"

Item {
    id: root
    required property string text
    property int maxWidth: 250
    property int font_size: 12

    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight
    width: Math.min(implicitWidth, maxWidth)

    clip: true

    BarText {
        id: label
        text: root.text
        color: "white"
        font.pixelSize: root.font_size
        anchors.verticalCenter: parent.verticalCenter
        x: 0

        onTextChanged: x = 0

        SequentialAnimation on x {
            running: label.implicitWidth > root.width
            loops: Animation.Infinite

            PauseAnimation {
                duration: 1500
            }
            NumberAnimation {
                to: root.width - label.implicitWidth
                duration: Math.abs(root.width - label.implicitWidth) * 25
                easing.type: Easing.InOutSine
            }
            PauseAnimation {
                duration: 1500
            }
            NumberAnimation {
                to: 0
                duration: Math.abs(root.width - label.implicitWidth) * 25
                easing.type: Easing.InOutSine
            }
        }
    }
}
