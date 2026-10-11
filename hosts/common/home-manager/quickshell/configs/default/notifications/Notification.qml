import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications
import "../bar/components/arrows"
import "../bar/components"
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
                                modelData.actions[0].invoke();
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

                        Item {
                            width: layoutColumn.width
                            height: layoutColumn.height
                        }

                        Row {
                            id: main
                            NotificationImage {
                                image: modelData.image
                                icon: modelData.appIcon
                            }
                            spacing: 10
                            Column {
                                id: layoutColumn
                                spacing: 4

                                NotificationText {
                                    maximumLineCount: 1
                                    text: modelData.summary
                                    font.bold: true
                                }
                                NotificationText {
                                    text: modelData.body
                                    maximumLineCount: 3
                                    visible: text !== ""
                                }
                            }
                        }

                        Timer {
                            running: true
                            interval: modelData.expireTimeout > 0 ? modelData.expireTimeout * 1000 : 5000
                            onTriggered: exitAnim.running = true
                        }
                    }
                }
            }
        }
    }
}
