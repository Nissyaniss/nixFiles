import QtQuick
import Quickshell.Services.Mpris
import "../../components/arrows"
import "../../components"
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
        }
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

    Item {
        id: here
        z: -1
        width: player.position / player.length * parent.width
        height: parent.height
        clip: true
        x: -parent.x
        y: -parent.y

        RightArrow {
            anchors.fill: parent
            width: mpris.width
            color: "#666666"
            height: 40
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true

        acceptedButtons: Qt.LeftButton
        onClicked: mouse => {
            player.isPlaying ? player.pause() : player.play();
        }

        onEntered: isHoveringMpris = true

        onExited: isHoveringMpris = false
    }
}
