pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import Quickshell.Services.SystemTray
import "../../../common/arrows"
import "../../../common"

EndRightHexagone {
    id: root

    required property PanelWindow topbarRef

    Row {
        leftPadding: 15
        spacing: 10
        anchors.verticalCenter: parent.verticalCenter
        Repeater {
            model: SystemTray.items

            delegate: Image {
                id: trayIcon
                required property SystemTrayItem modelData

                source: modelData.icon
                sourceSize: Qt.size(20, 20)
                visible: source.toString() !== "image://icon/media-optical" // udiskie shitting itself

                QsMenuAnchor {
                    id: menuAnchor
                    anchor.window: root.topbarRef
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: mouse => {
                        if (mouse.button === Qt.LeftButton) {
                            trayIcon.modelData.activate();
                        } else if (mouse.button === Qt.RightButton) {
                            if (trayIcon.modelData.hasMenu) {
                                menuAnchor.menu = trayIcon.modelData.menu;

                                let pos = trayIcon.mapToItem(null, mouse.x, mouse.y);
                                menuAnchor.anchor.rect = Qt.rect(pos.x, pos.y, 0, 0);
                                menuAnchor.open();
                            }
                        }
                    }
                }
            }
        }
    }
}
