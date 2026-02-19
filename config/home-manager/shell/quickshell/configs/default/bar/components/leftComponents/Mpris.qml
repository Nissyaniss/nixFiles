import QtQuick
import Quickshell.Services.Mpris
import "../../components/arrows"
import "../../components"
import "./mprisComponents"

RightArrow {
    readonly property list<MprisPlayer> availablePlayers: Mpris.players.values
    property MprisPlayer player: availablePlayers.find(p => p.isPlaying) ?? availablePlayers.find(p => p.canControl && p.canPlay) ?? null
    property bool isHoveringMpris: false

    Timer {
        interval: 20
        running: true
        repeat: true
        onTriggered: {
            player.positionChanged();
        }
    }

    visible: player == null ? false : true
    Item {
        width: layoutRow.width
        height: layoutRow.height

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            propagateComposedEvents: true

            onClicked: player.togglePlaying()
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
        z: -1
        width: player.position / player.length * parent.width
        height: parent.height
        clip: true
        x: -parent.x
        y: -parent.y

        RightArrow {
            width: parent.parent.width
            height: parent.parent.height
            color: "#666666"
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true

        acceptedButtons: Qt.LeftButton
        // onClicked: player.togglePlaying()

        onEntered: isHoveringMpris = true

        onExited: isHoveringMpris = false
    }
}
