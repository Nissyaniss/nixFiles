import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Io
import "./rightComponents"

Item {
    id: rightModules
    required property PanelWindow topbarRef

    Layout.fillWidth: true
    Layout.fillHeight: true

    FileView {
        id: procStat
        path: "/proc/stat"
        blockLoading: true
    }

    FileView {
        id: procMeminfo
        path: "/proc/meminfo"
        blockLoading: true
    }

    FileView {
        id: procNet
        path: "/proc/net/dev"
        blockLoading: true
    }

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
                    procStat.reload();
                    procMeminfo.reload();
                    procNet.reload();
                    cpu.updateCpu(procStat.text());
                    mem.updateMemory(procMeminfo.text());
                    network.updateNetwork(procNet.text());
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

        Battery {}

        Systray {
            topbarRef: rightModules.topbarRef
        }
    }
}
