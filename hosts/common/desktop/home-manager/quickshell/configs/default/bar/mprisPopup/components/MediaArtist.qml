import QtQuick
import Quickshell.Services.Mpris
import "../../../common"

Item {
    id: artist
    required property MprisPlayer player
    required property int info_width

    width: Math.min(artistText.implicitWidth, info_width - 40)
    implicitHeight: artistText.implicitHeight - 6
    clip: true

    ScrollingText {
        id: artistText
        anchors.verticalCenter: parent.verticalCenter
        maxWidth: artist.info_width - 40
        text: artist.player?.trackArtist ?? ""
        font_size: 15
    }
}
