import "../../../components"
import QtQuick
import Quickshell.Services.Mpris

Item {
    id: title
    property MprisPlayer mprisPlayer
    width: Math.min(titleText.implicitWidth, 250)
    implicitHeight: titleText.implicitHeight - 6
    clip: true

    BarText {
        id: titleText
        text: mprisPlayer.trackTitle
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
