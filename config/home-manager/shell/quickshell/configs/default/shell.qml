//@ pragma UseQApplication
import Quickshell
import QtQuick.Layouts
import "./bar/components"

PanelWindow {
    id: topBar
    height: 40
    color: "transparent"
    anchors {
        top: true
        left: true
        right: true
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0

        LeftModules {}

        MiddleModules {}

        RightModules {}
    }
}
