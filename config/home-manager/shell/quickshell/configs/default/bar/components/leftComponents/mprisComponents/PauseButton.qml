import "../../../components"
import QtQuick
import Quickshell.Services.Mpris

BarText {
    property MprisPlayer mprisPlayer
    text: mprisPlayer.isPlaying ? "" : ""
    color: "white"
    height: 40
    anchors.verticalCenter: parent.verticalCenter
    font.pixelSize: 30

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        onClicked: mprisPlayer.togglePlaying()
    }
}
