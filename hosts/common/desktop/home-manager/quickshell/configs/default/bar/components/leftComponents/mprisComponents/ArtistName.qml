import "../../../../common"
import QtQuick
import Quickshell.Services.Mpris

Item {
    id: artist
    property MprisPlayer mprisPlayer
    width: Math.min(artistText.implicitWidth, 250)
    implicitHeight: artistText.implicitHeight
    clip: true

    ScrollingText {
        id: artistText
        text: artist.mprisPlayer?.trackArtist ?? ""
    }
}
