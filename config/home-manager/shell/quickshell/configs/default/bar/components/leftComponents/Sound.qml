import "../../components"
import "../../components/arrows"
import QtQuick
import Quickshell.Services.Pipewire

RightArrow {
    PwObjectTracker {
        objects: [node]
    }
    property PwNode node: Pipewire.defaultAudioSink
    property bool hasWheeled: false
    property int volumePercent: Math.round(node.audio.volume * 100)

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
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10
        BarText {
            text: node.audio.muted || node.audio.volume == 0 ? "" : ""
            font.pixelSize: 30
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onWheel: mouse => {
                    if (mouse.angleDelta.y > 0 && node.audio.volume < 1) {
                        node.audio.volume += 0.01;
                    } else {
                        node.audio.volume -= 0.01;
                    }
                    hasWheeled = true;
                    timer.restart();
                }
                onClicked: {
                    node.audio.muted = !node.audio.muted;
                }
            }
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
}
