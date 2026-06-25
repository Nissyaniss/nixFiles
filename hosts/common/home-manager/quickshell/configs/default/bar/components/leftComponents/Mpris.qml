import QtQuick
import Quickshell.Services.Mpris
import "../../components/arrows"
import "../../components"
import "./mprisComponents"
import "./mprisComponents/popup"

RightArrow {
    id: mpris
    readonly property list<MprisPlayer> availablePlayers: Mpris.players.values
    property MprisPlayer player: availablePlayers.find(p => p.isPlaying) ?? availablePlayers.find(p => p.canControl && p.canPlay) ?? null
    property bool isHoveringMpris: false
    property bool showMusicPopup: false

    visible: player == null ? false : true

    Timer {
        interval: 500
        running: player != null && player.isPlaying
        repeat: true
        onTriggered: {
            if (player) player.positionChanged();
        }
    }

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

    Popup {
        showMusicPopup: mpris.showMusicPopup
    }

    Item {
        z: -1
        width: mpris.width - 20
        height: mpris.height
        x: -parent.x - 1
        y: -parent.y
        RightArrow {
            width: (player && player.length > 0 ? player.position / player.length * parent.width : 0) + 20
            height: mpris.height
            color: "#666666"
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
        cursorShape: Qt.PointingHandCursor

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button == Qt.LeftButton) {
                player.isPlaying ? player.pause() : player.play();
            } else {
                showMusicPopup = !showMusicPopup;
            }
        }

        onEntered: isHoveringMpris = true

        onExited: isHoveringMpris = false
    }

    Row {
        id: layoutRow
        height: 40
        anchors.verticalCenter: parent.verticalCenter

        PreviousButton {
            mprisPlayer: player
            width: isHoveringMpris ? implicitWidth : 0
            Behavior on width {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutExpo
                }
            }
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
            width: isHoveringMpris ? implicitWidth : 0
            Behavior on width {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutExpo
                }
            }
        }
    }
}
