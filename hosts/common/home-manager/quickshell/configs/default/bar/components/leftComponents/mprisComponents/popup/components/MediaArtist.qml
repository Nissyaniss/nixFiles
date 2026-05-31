import QtQuick
import "../../../../../components"

Item {
    id: artist
    width: Math.min(artistText.implicitWidth, info.width - 40)
    implicitHeight: artistText.implicitHeight - 6
    clip: true

    BarText {
        id: artistText
        text: player.trackArtist
        color: "white"
        font.pixelSize: 15
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
