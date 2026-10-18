import QtQuick
import Quickshell.Hyprland
import "../../components"
import "../../../common/arrows"
import "../../../common"

RightArrow {
    Row {
        spacing: 15
        Repeater {
            model: Hyprland.workspaces
            BarText {
                id: workspaceIcon
                anchors.verticalCenter: parent.verticalCenter
                property var workspace: modelData
                text: workspace.focused ? "" : ""
                color: "white"
                font {
                    bold: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: workspaceIcon.workspace.activate()
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
