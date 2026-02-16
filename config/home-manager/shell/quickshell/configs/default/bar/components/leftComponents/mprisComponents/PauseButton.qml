import "../../../components"
import QtQuick
import Quickshell.Services.Mpris

BarText {
    property MprisPlayer mprisPlayer
    text: mprisPlayer.isPlaying ? "⏸" : "▶"
    color: "white"
    height: 40
    anchors.verticalCenter: parent.verticalCenter
    font.pixelSize: 25
    leftPadding: mprisPlayer.isPlaying ? 5 : 10
}
