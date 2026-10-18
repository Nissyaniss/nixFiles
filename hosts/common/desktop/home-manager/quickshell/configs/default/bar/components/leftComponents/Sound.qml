import "../../components"
import "../../../common/arrows"
import "../../../common"
import QtQuick
import Quickshell.Services.Pipewire

RightArrow {
    id: sound
    PwObjectTracker {
        objects: [sound.node]
    }
    property PwNode node: Pipewire.defaultAudioSink
    property bool hasWheeled: false
    property int volumePercent: Math.round(node?.audio.volume * 100)
    signal popupRequested(name: string)

    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            if (sound.hasWheeled) {
                sound.hasWheeled = false;
            }
        }
    }

    Row {
        id: main
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10
        BarText {
            text: sound.node?.audio.muted || sound.node?.audio.volume == 0 ? "" : ""
            font.pixelSize: 30
        }

        BarText {
            anchors.verticalCenter: parent.verticalCenter
            width: sound.hasWheeled ? implicitWidth : 0
            text: sound.volumePercent
            clip: true
            Behavior on width {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
        cursorShape: Qt.PointingHandCursor

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onWheel: mouse => {
            if (sound.node && mouse.angleDelta.y > 0 && sound.node.audio.volume < 1) {
                sound.node.audio.volume = Math.min(1, sound.node.audio.volume + 0.01);
            } else if (sound.node && mouse.angleDelta.y < 0 && sound.node.audio.volume > 0) {
                sound.node.audio.volume = Math.max(0, sound.node.audio.volume - 0.01);
            }
            sound.hasWheeled = true;
            timer.restart();
        }
        onClicked: mouse => {
            if (mouse.button == Qt.LeftButton) {
                if (sound.node) {
                    sound.node.audio.muted = !sound.node.audio.muted;
                }
            } else {
                sound.popupRequested("mixer");
            }
        }
    }
}
