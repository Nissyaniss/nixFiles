import QtQuick
import QtQuick.Shapes

Item {
    id: seg
    default property alias content: contentContainer.data

    readonly property int pw: 12
    width: contentContainer.width + 10 + pw * 2
    height: 40
    anchors.verticalCenter: parent.verticalCenter

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4
        ShapePath {
            fillColor: "#1a1a1a"
            strokeColor: "transparent"

            startX: 0
            startY: 0

            PathLine {
                x: seg.width
                y: 0
            }
            PathLine {
                x: seg.width - 20
                y: seg.height / 2
            }
            PathLine {
                x: seg.width
                y: seg.height
            }
            PathLine {
                x: 0
                y: seg.height
            }
            PathLine {
                x: 0
                y: 0
            }
        }
    }

    Item {
        id: contentContainer
        anchors.centerIn: parent
        width: children.length > 0 ? children[0].width : 0
        height: children.length > 0 ? children[0].height : 0
    }
}
