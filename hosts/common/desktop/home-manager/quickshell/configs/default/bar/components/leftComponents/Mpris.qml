import QtQuick
import Quickshell.Services.Mpris
import "../../../common/arrows"
import "./mprisComponents"

RightArrow {
    id: mpris
    required property MprisPlayer player
    property bool isHoveringMpris: false
    signal popupRequested(name: string)
    height: layoutRow.height

    visible: player == null ? false : true

    Item {
        width: layoutRow.width
        height: layoutRow.height
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true

        cursorShape: Qt.PointingHandCursor

        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onEntered: mpris.isHoveringMpris = true

        onExited: mpris.isHoveringMpris = false

        onClicked: mouse => {
            if (mouse.button == Qt.LeftButton) {
                mpris.player.togglePlaying();
            } else {
                mpris.popupRequested("mpris");
            }
        }
    }

    Item {
        z: -1
        width: mpris.width - 20
        height: mpris.height
        x: -parent.x - 1
        y: -parent.y
        RightArrow {
            width: (mpris.player && mpris.player.length > 0 ? mpris.player.position / mpris.player.length * parent.width : 0) + 20
            height: mpris.height
            color: "#666666"
        }
    }

    Row {
        id: layoutRow
        height: 40
        anchors.verticalCenter: parent.verticalCenter

        PreviousButton {
            mprisPlayer: mpris.player
            width: mpris.isHoveringMpris ? implicitWidth : 0
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
                mprisPlayer: mpris.player
            }

            ArtistName {
                mprisPlayer: mpris.player
            }
        }
        PauseButton {
            mprisPlayer: mpris.player
        }
        SkipButton {
            mprisPlayer: mpris.player
            width: mpris.isHoveringMpris ? implicitWidth : 0
            Behavior on width {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutExpo
                }
            }
        }
    }
}
