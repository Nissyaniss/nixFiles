import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick

Item {
    id: recordPlayerContainer
    required property MprisPlayer player

    width: 200
    height: 200
    property bool isZenBrowser: false
    property int rotation: 0
    Timer {
        interval: 20
        running: recordPlayerContainer.player != null && recordPlayerContainer.player.isPlaying
        repeat: true
        onTriggered: {
            if (!recordPlayerContainer.player)
                return;
            if (recordPlayerContainer.rotation == 360 && recordPlayerContainer.isZenBrowser == false && recordPlayerContainer.player.isPlaying) {
                recordPlayerContainer.rotation = 0;
            } else if (recordPlayerContainer.isZenBrowser == false && recordPlayerContainer.player.isPlaying) {
                recordPlayerContainer.rotation = recordPlayerContainer.rotation + 1;
            }
            if (recordPlayerContainer.player.desktopEntry == "zen" && recordPlayerContainer.player.isPlaying) {
                recordPlayerContainer.isZenBrowser = true;
            } else if (recordPlayerContainer.player.isPlaying) {
                recordPlayerContainer.isZenBrowser = false;
            }
        }
    }

    ClippingRectangle {
        id: cover
        anchors.fill: parent
        radius: Infinity

        Image {
            id: image
            anchors.fill: parent
            source: recordPlayerContainer.isZenBrowser ? "../assets/ZenLogo.svg" : (recordPlayerContainer.player ? recordPlayerContainer.player.trackArtUrl : "")
            asynchronous: true
            fillMode: Image.PreserveAspectCrop
        }

        Rectangle {
            visible: !recordPlayerContainer.isZenBrowser
            anchors.centerIn: parent
            width: 50
            height: 50
            color: "#1a1a1a"
            radius: Infinity
            Rectangle {
                anchors.centerIn: parent
                width: 20
                height: 20
                color: "#666666"
                radius: Infinity
            }
        }

        transform: Rotation {
            origin.x: 100
            origin.y: 100
            angle: recordPlayerContainer.rotation
        }
    }

    Rectangle {
        id: tonearm
        visible: !recordPlayerContainer.isZenBrowser
        width: 8
        height: 100
        color: "#666666"
        radius: 4
        antialiasing: true

        x: parent.width * 0.8
        y: parent.height + 19

        transform: Rotation {
            origin.x: 4
            origin.y: 4
            angle: recordPlayerContainer.player != null && recordPlayerContainer.player.isPlaying ? 140 : 210

            Behavior on angle {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Rectangle {
            width: 16
            height: 24
            color: "#333"
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
