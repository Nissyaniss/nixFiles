import QtQuick
import Quickshell.Io
import "../../components"
import "../../components/arrows"

EndLeftHexagone {
    Process {
        id: wleave
        command: ["wleave"]
    }

    BarText {
        id: name
        text: "⏻"
        color: "white"
        leftPadding: -5
        rightPadding: 5
    }
    MouseArea {
        anchors.fill: parent
        onClicked: wleave.running = true
    }
}
