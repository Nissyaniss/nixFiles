import "../../../../../components/arrows"
import QtQuick
import QtQuick.Controls

Slider {
    id: slider

    implicitWidth: 200
    implicitHeight: 30

    padding: 0

    from: 0
    to: player.length

    Connections {
        target: player
        function onPositionChanged() {
            if (!slider.pressed) {
                slider.value = player.position;
            }
        }
    }

    background: Item {
        anchors.fill: parent

        RightArrow {
            color: "#3D3D3D"
            width: parent.width
            height: parent.height
        }

        Item {
            z: 1
            width: parent.parent.width
            height: 30
            x: -parent.x - 1
            y: -parent.y
            RightArrow {
                width: (player.position / player.length * parent.width)
                height: 30
                color: "#666666"
            }
        }
    }

    handle: Item {
        width: 0
        height: 0
    }

    onPressedChanged: {
        if (!pressed) {
            player.position = value;
        }
    }
}
