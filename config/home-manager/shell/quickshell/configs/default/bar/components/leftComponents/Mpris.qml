import QtQuick
import Quickshell.Services.Mpris
import "../../components/arrows"
import "./mprisComponents"

RightArrow {
    readonly property list<MprisPlayer> availablePlayers: Mpris.players.values
    property MprisPlayer player: availablePlayers.find(p => p.isPlaying) ?? availablePlayers.find(p => p.canControl && p.canPlay) ?? null
    property bool isHoveringMpris: false

    visible: player == null ? false : true
    Item {
        width: layoutRow.width
        height: layoutRow.height

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            propagateComposedEvents: true

            onClicked: player.isPlaying ? player.pause() : player.play()

            onEntered: isHoveringMpris = true

            onExited: isHoveringMpris = false
        }

        Row {
            id: layoutRow
            height: 40
            anchors.verticalCenter: parent.verticalCenter

            PreviousButton {
                mprisPlayer: player
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter
                MusicTitle {
                    mprisPlayer: player
                }

                ArtistName {
                    mprisPlayer: player
                }
            }
            PauseButton {
                mprisPlayer: player
            }
            SkipButton {
                mprisPlayer: player
            }
        }
    }
}
