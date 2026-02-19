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
    anchors.verticalCenter: parent.verticalCenter

    MouseArea {
        anchors.fill: parent
        onClicked: mprisPlayer.next()
    }
}
