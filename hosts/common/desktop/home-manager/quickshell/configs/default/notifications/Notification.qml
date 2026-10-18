import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications
import "../common/arrows"
import "./components"

Item {
    NotificationServer {
        id: server
        bodySupported: true
        keepOnReload: true
        actionsSupported: true
        imageSupported: true

        onNotification: notif => {
            notif.tracked = true;
        }
    }

    PanelWindow {
        anchors {
            top: true
            right: true
        }
        margins {
            top: 45
            right: 10
        }
        exclusionMode: ExclusionMode.Ignore
        color: "transparent"
        implicitWidth: 400
        implicitHeight: list.implicitHeight
        visible: server.trackedNotifications.values.length > 0

        ColumnLayout {
            id: list
            width: parent.width
            spacing: 8

            Repeater {
                model: server.trackedNotifications

                delegate: Item {
                    id: notification
                    required property var modelData

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: mouse => {
                            if (mouse.button == Qt.LeftButton) {
                                if (notification.modelData.actions[0]) {
                                    notification.modelData.actions[0].invoke();
                                } else {
                                    notification.modelData.dismiss();
                                }
                            } else if (mouse.button == Qt.RightButton) {
                                exitAnim.running = true;
                                exitAnim.isDismiss = true;
                            }
                        }
                    }
                    Layout.fillWidth: true
                    implicitHeight: arrow.height

                    LeftArrow {
                        id: arrow
                        leftAlign: true
                        height: main.implicitHeight + 20
                        width: notification.width
                        Component.onCompleted: {
                            x = 0;
                        }
                        x: 500

                        Behavior on x {
                            SpringAnimation {
                                spring: 10
                                damping: 0.5
                            }
                        }

                        SequentialAnimation {
                            id: exitAnim
                            property bool isDismiss: false

                            NumberAnimation {
                                target: arrow
                                property: "x"
                                to: 500
                                duration: 200
                                easing.type: Easing.InCubic
                            }
                            ScriptAction {
                                script: {
                                    if (exitAnim.isDismiss) {
                                        modelData.dismiss();
                                    } else {
                                        modelData.expire();
                                    }
                                }
                            }
                        }

                        Row {
                            id: main
                            NotificationImage {
                                modelData: notification.modelData
                            }
                            spacing: 10
                            Column {
                                id: layoutColumn
                                spacing: 4

                                NotificationText {
                                    width: arrow.width
                                    maximumLineCount: 1
                                    text: notification.modelData.summary
                                    font.bold: true
                                }
                                NotificationText {
                                    width: arrow.width
                                    text: notification.modelData.body
                                    maximumLineCount: 3
                                    visible: text !== ""
                                }
                            }
                        }

                        Timer {
                            running: true
                            interval: notification.modelData.expireTimeout > 0 ? notification.modelData.expireTimeout * 1000 : 5000
                            onTriggered: exitAnim.running = true
                        }
                    }
                }
            }
        }
    }
}
