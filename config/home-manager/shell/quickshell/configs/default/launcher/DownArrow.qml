import QtQuick
import QtQuick.Shapes

Item {
    id: seg
    default property alias content: contentContainer.data

    property string color: "#1a1a1a"
    readonly property int pw: 12
    width: contentContainer.width + 30 + pw * 2
    height: 40

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4
        ShapePath {
            fillColor: color
            strokeColor: "transparent"

            startX: 0
            startY: 0

            PathLine {
                x: seg.width / 2
                y: 40
            }
            PathLine {
                x: seg.width
                y: 0
            }
            PathLine {
                x: seg.width
                y: seg.height - 40
            }
            PathLine {
                x: seg.width / 2
                y: seg.height
            }
            PathLine {
                x: 0
                y: seg.height - 40
            }
        }
    }

    Item {
        id: contentContainer
        anchors.fill: parent
        anchors.topMargin: 15
        anchors.bottomMargin: 45
        anchors.leftMargin: 15
        anchors.rightMargin: 15
    }
}
