import "./arrows"
import QtQuick
import QtQuick.Controls

Slider {
    id: slider

    property alias color: progress.color

    implicitWidth: 200
    implicitHeight: 30

    padding: 0

    from: 0

    background: Item {
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
        anchors.fill: parent

        RightArrow {
            color: "#3D3D3D"
            width: parent.width
            height: parent.height
        }

        Item {
            width: slider.visualPosition * parent.width
            height: parent.height
            clip: true

            RightArrow {
                id: progress
                width: parent.parent.width
                height: parent.parent.height
                color: "#666666"
            }
        }
    }

    handle: Item {
        width: 0
        height: 0
    }
}
