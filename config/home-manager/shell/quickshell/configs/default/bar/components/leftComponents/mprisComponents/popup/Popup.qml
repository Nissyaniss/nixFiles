import Quickshell.Widgets
import QtQuick.Effects
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import "../../../../components"
import "../../../../components/arrows"
import "../."

PopupWindow {
    id: musicPopup
    property bool showMusicPopup: false
    property bool isZenBrowser: false
    property int rotation: 0

    color: "#1a1a1a"
    anchor.window: topBar
    anchor.rect.x: mpris.x
    anchor.rect.y: mpris.y + 40
    implicitHeight: main.implicitHeight + 20
    visible: showMusicPopup
    implicitWidth: main.implicitWidth + 20
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
            player.positionChanged();
        }
    }
    Row {
        id: main
        spacing: 10
        ClippingRectangle {
            id: cover

            anchors.verticalCenter: main.verticalCenter
            implicitWidth: 200
            implicitHeight: 200

            radius: Infinity

            Image {
                id: image

                anchors.fill: parent

                source: isZenBrowser ? "./assets/ZenLogo.svg" : player.trackArtUrl
                asynchronous: true
                sourceSize.width: width
                sourceSize.height: height
            }
            transform: Rotation {

                origin.x: image.width / 2

                origin.y: image.height / 2

                angle: rotation
            }
        }

        Column {
            id: test
            BarText {
                wrapMode: Text.WordWrap
                width: 200
                text: player.trackTitle
            }
            BarText {
                wrapMode: Text.WordWrap
                width: 200
                font.pixelSize: 15
                text: player.trackArtist
            }
            BarText {
                text: `${Math.round(player.position / 60)}:${Math.round(player.position % 60)} / ${Math.round(player.length / 60)}:${Math.round(player.length % 60)}`
            }
            Slider {
                id: slider
                from: 0
                to: player.length

                Binding {
                    target: slider
                    property: "value"
                    value: player.position
                    when: !slider.pressed
                }

                background: Item {
                    implicitWidth: 200
                    implicitHeight: 20
                    width: slider.availableWidth
                    height: slider.availableHeight

                    RightArrow {
                        color: "#3D3D3D"
                        width: 200
                        height: 20
                    }

                    Item {
                        width: slider.visualPosition * parent.width
                        height: parent.height
                        clip: true

                        RightArrow {
                            width: slider.availableWidth
                            color: "#89b4fa"
                            height: 20
                        }
                    }
                }

                handle: Rectangle {
                    visible: false
                }
                onPressedChanged: {
                    if (!pressed) {
                        player.position = value;
                    }
                }
            }
            Row {
                PreviousButton {
                    font.pixelSize: 30
                    color: player.canGoPrevious ? "white" : "gray"
                    mprisPlayer: player
                }
                PauseButton {
                    font.pixelSize: 30
                    leftPadding: player.isPlaying ? 72 : 62
                    mprisPlayer: player
                }
                SkipButton {
                    leftPadding: player.isPlaying ? 62 : 67
                    font.pixelSize: 30
                    color: player.canGoNext ? "white" : "gray"
                    mprisPlayer: player
                }
            }
        }
    }
}
