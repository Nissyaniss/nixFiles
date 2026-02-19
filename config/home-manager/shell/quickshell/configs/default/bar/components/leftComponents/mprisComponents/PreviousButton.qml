import "../../../components"
import QtQuick
import Quickshell.Services.Mpris

BarText {
    property MprisPlayer mprisPlayer

    text: "󰒫"
    color: "white"
    font.pixelSize: 25
    rightPadding: 10

    clip: true
    anchors.verticalCenter: parent.verticalCenter
    MouseArea {
        anchors.fill: parent
        onClicked: mprisPlayer.previous()
    }
}
