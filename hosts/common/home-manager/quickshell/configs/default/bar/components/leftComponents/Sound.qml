import "../../components"
import "../../components/arrows"
import "./soundMixer"
import QtQuick
import Quickshell.Services.Pipewire

RightArrow {
    id: sound
    PwObjectTracker {
        objects: [node]
    }
    property PwNode node: Pipewire.defaultAudioSink
    property bool hasWheeled: false
    property int volumePercent: Math.round(node.audio.volume * 100)
    property bool showMixer: false

    SoundMixer {
        showMixer: sound.showMixer
    }

    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            if (hasWheeled) {
                hasWheeled = false;
            }
        }
    }

    Row {
        id: main
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10
        BarText {
            text: node.audio.muted || node.audio.volume == 0 ? "" : ""
            font.pixelSize: 30
        }

        BarText {
            anchors.verticalCenter: parent.verticalCenter
            width: hasWheeled ? implicitWidth : 0
            text: volumePercent == 101 ? 100 : volumePercent
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
            if (mouse.angleDelta.y > 0 && node.audio.volume < 1) {
                node.audio.volume += 0.01;
            } else {
                node.audio.volume -= 0.01;
            }
            hasWheeled = true;
            timer.restart();
        }
        onClicked: mouse => {
            if (mouse.button == Qt.LeftButton) {
                node.audio.muted = !node.audio.muted;
            } else {
                showMixer = !showMixer;
            }
        }
    }
}
