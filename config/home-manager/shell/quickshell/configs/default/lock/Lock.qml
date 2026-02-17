import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pam
import QtQuick.Effects

ShellRoot {
    id: root
    property string pamText: ""
    property string color: "#11111b"
    property int activeCirclePart: -1
    property int previousActiveCirclePart: 0
    property int maxCircleParts: 5

    PamContext {
        id: pamContext
        config: "quickshell"

        onCompleted: result => {
            if (result === PamResult.Success) {
                sessionLock.locked = false;
                Qt.quit();
            } else {
                root.pamText = "Failed";
                pamContext.start();
            }
        }
    }

    function randomRGBA() {
        let r = Math.random();
        let g = Math.random();
        let b = Math.random();
        return Qt.rgba(r, g, b, 0.3);
    }

    function randomCirclePart() {
        let res = Math.floor(Math.random() * maxCircleParts);
        while (res === root.previousActiveCirclePart) {
            res = Math.floor(Math.random() * maxCircleParts);
        }
        root.activeCirclePart = res;
    }

    WlSessionLock {
        id: sessionLock
        locked: true

        WlSessionLockSurface {
            id: lockSurface
            Timer {
                id: timer
                interval: 2000
                running: true
                repeat: true
                onTriggered: {
                    if (root.pamText != "Checking...") {
                        root.pamText = "";
                    }
                    if (root.activeCirclePart != -1) {
                        root.activeCirclePart = -1;
                    }
                }
            }

            Image {
                anchors.fill: parent
                source: "file:///tmp/lock_bg_" + lockSurface.screen.name + ".png"
                fillMode: Image.PreserveAspectCrop

                layer.enabled: true
                layer.effect: MultiEffect {
                    blurEnabled: true
                    blurMax: 64
                    blur: 0.7
                }
            }

            Canvas {
                id: canvas
                property int listener: root.activeCirclePart
                onListenerChanged: canvas.requestPaint()

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 500
                height: 500

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    var centerX = width / 2;
                    var centerY = height / 2;
                    var radius = 200;

                    let circlePartLength = 2 / root.maxCircleParts;
                    for (let i = 0; i <= root.maxCircleParts; i++) {
                        if (root.activeCirclePart == i) {
                            ctx.beginPath();
                            ctx.arc(centerX, centerY, radius, i == 0 ? 0 : (circlePartLength * i) * Math.PI, (circlePartLength * (i + 1)) * Math.PI);
                            ctx.lineWidth = 50;
                            ctx.strokeStyle = root.randomRGBA();
                            ctx.stroke();
                        }
                    }

                    root.previousActiveCirclePart = root.activeCirclePart;
                }
            }

            TextField {
                id: passwordField
                visible: false
                echoMode: TextInput.Password
                focus: true
                horizontalAlignment: TextInput.AlignHCenter

                enabled: pamContext.responseRequired

                onAccepted: {
                    if (pamContext.responseRequired) {
                        pamContext.respond(text);
                        text = "";
                        root.pamText = "Checking...";
                    }
                }
                onTextChanged: {
                    if (text == "") {
                        root.pamText = "Cleared";
                    } else {
                        root.pamText = "";
                    }
                    timer.restart();
                    root.randomCirclePart();
                    canvas.requestPaint();
                }

                Keys.onEscapePressed: event => {
                    text = "";
                    root.pamText = "Cleared";
                    root.activeCirclePart = -1;
                    event.accepted = true;
                }
            }

            Text {
                text: root.pamText
                color: "white"
                font.pixelSize: 32
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Component.onCompleted: pamContext.start()
}
