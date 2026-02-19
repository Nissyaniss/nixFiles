import Quickshell.Widgets
import QtQuick

Item {
    id: recordPlayerContainer
    width: 200
    height: 200
    anchors.verticalCenter: musicPopup.verticalCenter
    property bool isZenBrowser: false
    property int rotation: 0
    Timer {
        interval: 20
        running: player.isPlaying
        repeat: true
        onTriggered: {
            if (rotation == 360 && isZenBrowser == false) {
                rotation = 0;
            } else if (isZenBrowser == false) {
                rotation = rotation + 1;
            }
            if (player.desktopEntry == "zen") {
                isZenBrowser = true;
            } else {
                isZenBrowser = false;
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
            source: isZenBrowser ? "./assets/ZenLogo.svg" : player.trackArtUrl
            asynchronous: true
            fillMode: Image.PreserveAspectCrop
        }

        Rectangle {
            visible: !isZenBrowser
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
            angle: rotation
        }
    }

    Rectangle {
        id: tonearm
        visible: !isZenBrowser
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
            angle: player.isPlaying ? 140 : 210

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
