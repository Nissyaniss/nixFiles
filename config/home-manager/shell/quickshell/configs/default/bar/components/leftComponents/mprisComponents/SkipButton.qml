import "../../../components"
import QtQuick
import Quickshell.Services.Mpris

BarText {
    property MprisPlayer mprisPlayer

    text: "󰒬"
    color: "white"
    font.pixelSize: 25
    clip: true
    leftPadding: 5
    width: isHoveringMpris ? implicitWidth : 0
    anchors.verticalCenter: parent.verticalCenter
    Behavior on width {
        NumberAnimation {
            duration: 200
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: mprisPlayer.next()
    }
}
