import "../../../components"
import QtQuick
import Quickshell.Services.Mpris

Item {
    id: artist
    property MprisPlayer mprisPlayer
    width: Math.min(artistText.implicitWidth, 250)
    implicitHeight: artistText.implicitHeight
    clip: true

    BarText {
        id: artistText
        text: mprisPlayer.trackArtist
        color: "white"
        font.pixelSize: 12
        anchors.verticalCenter: parent.verticalCenter
        x: 0

        onTextChanged: x = 0

        SequentialAnimation on x {
            running: artistText.implicitWidth > artist.width
            loops: Animation.Infinite

            PauseAnimation {
                duration: 1500
            }
            NumberAnimation {
                to: artist.width - artistText.implicitWidth
                duration: Math.abs(artist.width - artistText.implicitWidth) * 25
                easing.type: Easing.InOutSine
            }
            PauseAnimation {
                duration: 1500
            }
            NumberAnimation {
                to: 0
                duration: Math.abs(artist.width - artistText.implicitWidth) * 25
                easing.type: Easing.InOutSine
            }
        }
    }
}
