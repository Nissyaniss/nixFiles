import QtQuick
import Quickshell.Services.Mpris
import "../components"
import "./components"
import "../../common"

Item {
    id: musicPopup
    property bool showMusicPopup: false
    property real progress: showMusicPopup ? 1 : 0
    property int offset: 50
    required property MprisPlayer player
    property int mprisX

    x: mprisX * progress
    implicitHeight: main.implicitHeight
    visible: showMusicPopup || progressAnim.running
    opacity: Math.max(0, Math.min(1, progress))
    implicitWidth: main.implicitWidth + 20

    Behavior on progress {
        SpringAnimation {
            id: progressAnim
            spring: 10
            damping: 0.5
        }
    }

    PopupBackground {
        id: background
        offset: musicPopup.offset
    }

    Row {
        id: main
        spacing: 10
        topPadding: 10
        bottomPadding: 15

        RecordPlayer {
            player: musicPopup.player
        }

        Column {
            id: info
            spacing: 10

            MediaTitle {
                player: musicPopup.player
                info_width: info.width
            }
            MediaArtist {
                player: musicPopup.player
                info_width: info.width
            }
            BarText {
                height: 25
                width: info.width - background.offset
                text: `${Math.round(musicPopup.player?.position / 60)}:${String(Math.round(musicPopup.player?.position % 60)).padStart(2, '0')} / ${Math.round(musicPopup.player?.length / 60)}:${String(Math.round(musicPopup.player?.length % 60)).padStart(2, '0')}`
            }
            Seekbar {
                player: musicPopup.player
            }
            Controls {
                spacing: (info.width - background.offset) / 3 - 20
                player: musicPopup.player
            }
        }
    }
}
