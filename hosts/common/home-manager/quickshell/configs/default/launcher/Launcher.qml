import QtQuick
import Quickshell
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick.Controls
import Quickshell.Hyprland

PanelWindow {
    id: toplevel

    implicitWidth: 600
    implicitHeight: 600
    focusable: true
    color: "transparent"

    Shortcut {
        sequences: [StandardKey.Cancel]
        context: Qt.ApplicationShortcut
        onActivated: Qt.quit()
    }

    HyprlandFocusGrab {
        active: true
        windows: [toplevel]
    }

    DownArrow {
        anchors.fill: parent
        ColumnLayout {
            anchors.fill: parent
            TextField {
                id: search
                focus: true
                color: "white"
                leftPadding: 25
                Component.onCompleted: forceActiveFocus()
                Layout.fillWidth: true
                Keys.onUpPressed: {
                    list.decrementCurrentIndex();
                }
                Keys.onDownPressed: {
                    list.incrementCurrentIndex();
                }
                Keys.onReturnPressed: {
                    list.model.values[list.currentIndex].execute();
                    Qt.quit();
                }
                background: RightArrow {
                    width: parent.width - 10
                    height: parent.height
                    color: "#666666"
                }
            }
            ListView {
                id: list
                spacing: 15
                currentIndex: 0
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                keyNavigationEnabled: true
                model: ScriptModel {
                    values: [...DesktopEntries.applications.values].filter(entry => entry.name.toLowerCase().includes(search.text)).sort()
                    onValuesChanged: {
                        if (list.count > 0) {
                            list.currentIndex = 0;
                        }
                    }
                }
                highlight: Item {
                    RightArrow {
                        width: parent.width - 40
                        height: parent.height
                        color: "#666666"
                    }
                }
                delegate: MouseArea {
                    id: delegateRoot
                    implicitHeight: item.implicitHeight
                    implicitWidth: 600
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: false
                    onClicked: modelData.execute()
                    Row {
                        id: item
                        leftPadding: 25
                        IconImage {
                            source: Quickshell.iconPath(modelData.icon)
                            asynchronous: true
                            implicitSize: 30
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Column {
                            leftPadding: 10
                            Text {
                                text: modelData.name
                                color: "white"
                            }
                            Text {
                                text: modelData.comment.length > 90 ? modelData.comment.substring(0, 90) + "..." : modelData.comment
                                font.pixelSize: 10
                                color: "white"
                            }
                        }
                    }
                }
            }
        }
    }
}
