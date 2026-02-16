//@ pragma UseQApplication
import Quickshell
import QtQuick
import Quickshell.Services.SystemTray
import "../../components/arrows"
import "./mprisComponents"

EndRightHexagone {
    Row {
        leftPadding: 15
        spacing: 10
        anchors.verticalCenter: parent.verticalCenter
        Repeater {
            model: SystemTray.items

            delegate: Image {
                id: trayIcon
                source: modelData.icon
                sourceSize: Qt.size(20, 20)
                visible: source.toString() !== "image://icon/media-optical" // udikie shitting itself

                QsMenuAnchor {
                    id: menuAnchor
                    anchor.window: topBar
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: mouse => {
                        if (mouse.button === Qt.LeftButton) {
                            modelData.activate();
                        } else if (mouse.button === Qt.RightButton) {
                            if (modelData.hasMenu) {
                                menuAnchor.menu = modelData.menu;

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
