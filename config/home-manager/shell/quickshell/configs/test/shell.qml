import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray


PanelWindow {
    id: topBar
    height: 40
    color: "transparent"

    property string memUsage: "0%"
    property string cpuUsage: "0"
    property string networkUsage: " 0.0Mb/s /  0.0Mb/s"
    readonly property list<MprisPlayer> availablePlayers: Mpris.players.values
    property MprisPlayer player: availablePlayers.find(p => p.isPlaying) ?? availablePlayers.find(p => p.canControl && p.canPlay) ?? null

    anchors {
        top: true
        left: true
        right: true
    }
    Process {
        id: wleave
        command: ["wleave"]
    }

    Process {
        id: mem
        running: true
        command: ["nu", "-c", "(((sys mem).used / (sys mem).total) * 100 | math round | into string) + '%'"]
        stdout: StdioCollector {
            onStreamFinished: memUsage = this.text
        }

    }

    Process {
        id: cpu
        command: ["python3", "-u", "/home/nissya/.nixFiles/config/home-manager/shell/quickshell/configs/cpu.py"]
        stdout: StdioCollector {
            onStreamFinished: cpuUsage = this.text
        }
    }

    Process {
        id: network
        command: ["python3", "-u", "/home/nissya/.nixFiles/config/home-manager/shell/quickshell/configs/network.py"]
        stdout: StdioCollector {
            onStreamFinished: networkUsage = this.text
        }
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            mem.running = true
            cpu.running = true
            network.running = true
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        // Left
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Row {
                spacing: 15
                Text {
                    color: "white"
                    text: "⏻"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: wleave.running = true
                    }
                }
                Repeater {
                    model: Hyprland.workspaces
                    Text {
                        property var workspace: modelData
                        text: workspace.focused ? "" : ""
                        color: "white"
                        font {
                            family: root.fontFamily
                            pixelSize: root.fontSize
                            bold: true
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: workspace.activate()
                        }
                    }
                }
                Text {
                    text: player.isPlaying ? "⏸" : "▶"
                    color: "white"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: player.isPlaying ? player.pause() : player.play()
                        onHover: player.pause()
                    }
                }

                Column {
                    Text {
                        text: player.trackTitle
                        color: "white"
                        font.bold: true
                    }
                    Text {
                        text: player.trackArtist
                        color: "gray"
                        font.pixelSize: 10
                    }
                }
            }
        }

        // Middle
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            SystemClock {
                id: clock
                precision: SystemClock.Seconds
            }

            Row {
                anchors.centerIn: parent
                spacing: 15
                Text {
                    color: "white"
                    text: Qt.formatDateTime(clock.date, "ddd.")
                }
                Text {
                    color: "white"
                    text: Qt.formatDateTime(clock.date, "hh:mm:ss")
                }
                Text {
                    color: "white"
                    text: Qt.formatDateTime(clock.date, "dd/MM")
                }
            }
        }

        // Right
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Row {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10


                Text {
                    text: networkUsage
                    color: "white"
                }

                Text {
                    text: `Mem ${memUsage}`
                    color: "white"
                }

                Text {
                    text: `Cpu ${cpuUsage}%`
                    color: "white"
                }

                Repeater {
                    model: SystemTray.items

                    delegate: Image {
                        source: modelData.icon
                        sourceSize: Qt.size(20, 20)
                        visible: source.toString() !== "image://icon/media-optical" // usdikie shitting itself

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton
                            onClicked: mouse => {
                                if (mouse.button === Qt.LeftButton) {
                                    modelData.activate();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
