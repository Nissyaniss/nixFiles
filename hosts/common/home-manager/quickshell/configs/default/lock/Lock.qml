import QtQuick
import Quickshell
import Quickshell.Wayland
import "./components"
import "./arrows"

ShellRoot {
    id: root

    WlSessionLock {
        id: sessionLock
        locked: LockState.locked

        WlSessionLockSurface {
            id: lockSurface
            Timer {
                id: timer
                interval: 2000
                running: true
                repeat: true
                onTriggered: {
                    if (pamText.pamText != "Checking...") {
                        pamText.pamText = "";
                    }
                    if (circle.activeCirclePart != -1) {
                        circle.activeCirclePart = -1;
                    }
                }
            }

            PamContext {
                id: pamContext
            }

            // DEBUG

            // MouseArea {
            //     anchors.fill: parent
            //     cursorShape: Qt.PointingHandCursor
            //     hoverEnabled: false
            //     onEntered: {}
            //     onExited: {}
            //     onWheel: {}
            //     onClicked: {
            //         Qt.quit();
            //     }
            // }

            // DEBUG

            Background {}

            RightArrow {
                id: background
                width: parent.width
                height: parent.height
                offset: 200
                Behavior on width {
                    NumberAnimation {
                        duration: 1500
                        easing.type: Easing.OutExpo
                    }
                }
            }

            Circle {
                id: circle
            }

            PasswordField {}

            PamText {
                id: pamText
            }

            Component.onCompleted: pamContext.start()
        }
    }
}
