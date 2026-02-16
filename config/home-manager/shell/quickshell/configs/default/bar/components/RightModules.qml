import QtQuick
import QtQuick.Layouts
import "./rightComponents"

Item {
    id: leftModules
    property bool cpu_running
    Layout.fillWidth: true
    Layout.fillHeight: true
    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: -5
        Row {
            anchors.verticalCenter: parent.verticalCenter
            spacing: -5

            Timer {
                interval: 500
                running: true
                repeat: true
                onTriggered: {
                    cpu.running = true;
                    mem.running = true;
                    network.running = true;
                }
            }

            Network {
                id: network
            }

            Memory {
                id: mem
            }

            Cpu {
                id: cpu
            }
        }

        Systray {}
    }
}
