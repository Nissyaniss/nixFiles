import QtQuick
import Quickshell.Hyprland
import "../../components"
import "../../components/arrows"

RightArrow {
    Row {
        spacing: 15
        Repeater {
            model: Hyprland.workspaces
            BarText {
                anchors.verticalCenter: parent.verticalCenter
                property var workspace: modelData
                text: workspace.focused ? "" : ""
                color: "white"
                font {
                    bold: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: workspace.activate()
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
