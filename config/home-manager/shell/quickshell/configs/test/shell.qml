import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import Quickshell.Services.Mpris
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import QtQuick.Shapes

PanelWindow {
    id: topBar
    height: 40
    color: "transparent"

    component HexSegment: Item {
        id: seg
        property string text: ""
        property bool isLeft: false
        property bool endLeft: false
        property bool isRight: false
        property bool endRight: false
        property bool isMiddle: false

        readonly property int pw: 12 // Point Width
        width: label.width + (isMiddle ? pw * 3 : pw * 2) + 10 + (isLeft ? 30 : 0) + (isRight ? 30 : 0) + (isMiddle ? 30 : 0)
        height: 40
        anchors.verticalCenter: parent.verticalCenter

        Shape {
            anchors.fill: parent
            layer.enabled: true
            layer.samples: 4
            ShapePath {
                fillColor: "#1a1a1a"
                strokeColor: "transparent"

                // Logic for the shape points based on position
                startX: endLeft ? 0 : seg.pw
                startY: 0

                PathLine {
                    x: endRight ? seg.width : isMiddle ? seg.width - seg.pw - 10 : isRight ? seg.width - 20 : isLeft ? seg.width : 0
                    y: 0
                }
                PathLine {
                    x: isLeft ? seg.width - 20 : seg.width
                    y: seg.height / 2
                }
                PathLine {
                    x: endRight ? seg.width : isMiddle ? seg.width - seg.pw - 10 : isRight ? seg.width - 20 : isLeft ? seg.width : 0
                    y: seg.height
                }
                PathLine {
                    x: endLeft ? 0 : isRight ? 0 : seg.pw + 10
                    y: seg.height
                }
                PathLine {
                    x: 0 + (isRight ? 20 : 0)
                    y: seg.height / 2
                }
                PathLine {
                    x: endLeft ? 0 : isRight ? 0 : seg.pw + 10
                    y: 0
                }
            }
        }

        Text {
            id: label
            anchors.centerIn: parent
            text: seg.text
            color: "white"
            font.family: "JetBrains Mono"
        }
    }

    property string memUsage: "0%"
    property string cpuUsage: "0"
    property string networkUsage: " 0.0Mb/s /  0.0Mb/s"
    readonly property list<MprisPlayer> availablePlayers: Mpris.players.values
    property MprisPlayer player: availablePlayers.find(p => p.isPlaying) ?? availablePlayers.find(p => p.canControl && p.canPlay) ?? null

    property bool isHoveringMpris: false

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
            mem.running = true;
            cpu.running = true;
            network.running = true;
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
                HexSegment {
                    text: "⏻"
                    endLeft: true
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
                            bold: true
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: workspace.activate()
                        }
                    }
                }

                Item {
                    width: layoutRow.width
                    height: layoutRow.height

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        propagateComposedEvents: true

                        onClicked: player.isPlaying ? player.pause() : player.play()

                        onEntered: isHoveringMpris = true

                        onExited: isHoveringMpris = false
                    }

                    Row {
                        id: layoutRow
                        spacing: 10
                        Text {
                            text: "󰒫"
                            color: "white"
                            visible: isHoveringMpris
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 25

                            MouseArea {
                                anchors.fill: parent
                                onClicked: player.previous()
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
                                color: "white"
                                font.pixelSize: 10
                            }
                        }
                        Text {
                            text: player.isPlaying ? "⏸" : "▶"
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 25
                        }
                        Text {
                            text: "󰒬"
                            color: "white"
                            visible: isHoveringMpris
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 25

                            MouseArea {
                                anchors.fill: parent
                                onClicked: player.next()
                            }
                        }
                    }
                }
            }
        }

        // Middle
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Row {
                anchors.centerIn: parent
                spacing: -5

                // 1. Day Segment (Flat left, Pointed right)
                HexSegment {
                    text: Qt.formatDateTime(clock.date, "ddd.")
                    isLeft: true
                }

                // 2. Time Segment (Pointed left, Pointed right)
                HexSegment {
                    text: Qt.formatDateTime(clock.date, "hh:mm:ss")
                    isMiddle: true
                }

                // 3. Date Segment (Pointed left, Flat right)
                HexSegment {
                    text: Qt.formatDateTime(clock.date, "dd/MM")
                    isRight: true
                }

                SystemClock {
                    id: clock
                    precision: SystemClock.Seconds
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

                HexSegment {
                    text: networkUsage
                    isLeft: true
                }

                HexSegment {
                    text: `Mem ${memUsage}`
                    isLeft: true
                }

                HexSegment {
                    text: `Cpu ${cpuUsage}%`
                    isLeft: true
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
