pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "./components"
import "../common/arrows"

Scope {
    id: root
    property string message: ""

    function activate(): void {
        screenshotCommand.running = true;
    }

    Process {
        id: screenshotCommand
        running: false
        command: ["sh", "-c", "for output in $(hyprctl monitors -j | jq -r '.[].name'); do grim -o \"$output\" \"$XDG_RUNTIME_DIR/lock_bg_$output.png\"; done"]
        onExited: {
            sessionLock.locked = true;
            pamContext.start();
            root.message = "";
        }
    }

    PamContext {
        id: pamContext
        onRequestLock: {
            sessionLock.locked = !sessionLock.locked;
        }
        onRequestMessageChange: message => {
            root.message = message;
        }
    }

    WlSessionLock {
        id: sessionLock
        locked: false

        WlSessionLockSurface {
            id: lockSurface
            Timer {
                id: timer
                interval: 2000
                running: true
                repeat: true
                onTriggered: {
                    if (root.message != "Checking...") {
                        root.message = "";
                    }
                    if (circle.activeCirclePart != -1) {
                        circle.activeCirclePart = -1;
                    }
                }
            }

            Background {
                screen_name: lockSurface.screen?.name ?? ""
            }

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

            PasswordField {
                enabled: pamContext.responseRequired
                onRequestRespond: message => {
                    pamContext.respond(message);
                }
                onRequestMessageChange: message => {
                    root.message = message;
                }
                onRequestRestartTimer: {
                    timer.restart();
                }
                onRequestRandomCirclePart: {
                    circle.randomCirclePart();
                }
                onRequestActiveCirclePartChange: activeCirclePart => {
                    circle.activeCirclePart = activeCirclePart;
                }
            }

            PamText {
                id: pamText
                pamText: root.message
            }
        }
    }
}
