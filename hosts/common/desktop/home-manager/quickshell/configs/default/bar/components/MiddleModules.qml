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

        DateText {
            date: clock.date
        }

        HourText {
            date: clock.date
        }

        DateNumber {
            date: clock.date
        }

        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }
    }
}
