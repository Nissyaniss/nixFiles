import QtQuick
import QtQuick.Shapes

Item {
    id: seg
    default property alias content: contentContainer.data

    property string color: "#1a1a1a"
    readonly property int pw: 12
    width: contentContainer.width + pw * 2
    height: 40

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4
        ShapePath {
            fillColor: color
            strokeColor: "transparent"

            startX: seg.pw
            startY: 0

            PathLine {
                x: seg.width
                y: 0
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
                x: 20
                y: seg.height / 2
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
