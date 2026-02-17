import QtQuick
import Quickshell
import Quickshell.Wayland
import "./components"

ShellRoot {
    id: root

    PamContext {
        id: pamContext
    }

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
                    if (pmaText.pamText != "Checking...") {
                        pmaText.pamText = "";
                    }
                    if (circle.activeCirclePart != -1) {
                        circle.activeCirclePart = -1;
                    }
                }
            }

            Background {}

            Circle {
                id: circle
            }

            PasswordField {}

            PmaText {
                id: pmaText
            }
        }
    }

    Component.onCompleted: pamContext.start()
}
