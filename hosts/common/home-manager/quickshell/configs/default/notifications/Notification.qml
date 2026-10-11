import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications
import "../bar/components/arrows"
import "../bar/components"

Item {
    NotificationServer {
        id: server
        bodySupported: true
        keepOnReload: true
        actionsSupported: true

        onNotification: n => {
            n.tracked = true;
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
        implicitWidth: 320
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
                        onClicked: modelData.dismiss()
                    }
                    Layout.fillWidth: true
                    implicitHeight: arrow.height

                    LeftArrow {
                        id: arrow
                        leftAlign: true
                        height: layoutColumn.implicitHeight + 20
                        width: notification.width
                        Component.onCompleted: {
                            x = 0;
                            opacity = 1;
                        }
                        x: 500

                        Behavior on x {
                            SpringAnimation {
                                spring: 10
                                damping: 0.5
                            }
                        }

                        Item {
                            width: layoutColumn.width
                            height: layoutColumn.height
                        }

                        Column {
                            id: layoutColumn
                            spacing: 4

                            BarText {
                                text: modelData.summary
                                font.bold: true
                                Layout.fillWidth: true
                                wrapMode: Text.Wrap
                            }
                            BarText {
                                text: modelData.body
                                visible: text !== ""
                                Layout.fillWidth: true
                                wrapMode: Text.Wrap
                            }
                            BarText {
                                text: modelData.actions[0].identifier
                                visible: text !== ""
                                Layout.fillWidth: true
                                wrapMode: Text.Wrap
                            }
                        }

                        Timer {
                            running: true
                            interval: modelData.expireTimeout > 0 ? modelData.expireTimeout * 1000 : 5000
                            onTriggered: modelData.expire()
                        }
                    }
                }
            }
        }
    }
}
