import QtQuick
import QtQuick.Layouts
import "./middleComponents"
import Quickshell

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true

    Row {
        anchors.centerIn: parent
        spacing: -5

        DateText {}

        HourText {}

        DateNumber {}

        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }
    }
}
