import "../../../components"
import QtQuick
import Quickshell.Services.Mpris

BarText {
    property MprisPlayer mprisPlayer
    anchors.verticalCenter: parent.verticalCenter

    text: "󰒫"
    color: "white"
    font.pixelSize: 25
    rightPadding: 10

    clip: true
    width: isHoveringMpris ? implicitWidth : 0
    Behavior on width {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutExpo
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: mprisPlayer.previous()
    }
}
