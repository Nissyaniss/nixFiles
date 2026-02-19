import QtQuick
import "../../../../../components"

Item {
    id: title
    width: Math.min(titleText.implicitWidth, info.width - 40)
    implicitHeight: titleText.implicitHeight - 6
    clip: true

    BarText {
        id: titleText
        text: player.trackTitle
        color: "white"
        anchors.verticalCenter: parent.verticalCenter
        x: 0

        onTextChanged: x = 0

        SequentialAnimation on x {
            running: titleText.implicitWidth > title.width
            loops: Animation.Infinite

            PauseAnimation {
                duration: 1500
            }
            NumberAnimation {
                to: title.width - titleText.implicitWidth
                duration: Math.abs(title.width - titleText.implicitWidth) * 25
                easing.type: Easing.InOutSine
            }
            PauseAnimation {
                duration: 1500
            }
            NumberAnimation {
                to: 0
                duration: Math.abs(title.width - titleText.implicitWidth) * 25
                easing.type: Easing.InOutSine
            }
        }
    }
}
