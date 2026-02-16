import QtQuick
import QtQuick.Shapes

Item {
    id: seg
    default property alias content: contentContainer.data
    property bool isLeft: false
    property bool endLeft: false
    property bool isRight: false
    property bool endRight: false
    property bool isMiddle: false

    readonly property int pw: 12
    width: contentContainer.width + (isMiddle ? pw * 3 : pw * 2) + 10 + (isLeft ? 30 : 0) + (isRight ? 30 : 0) + (isMiddle ? 30 : 0)
    height: 40
    anchors.verticalCenter: parent.verticalCenter

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4
        ShapePath {
            fillColor: "#1a1a1a"
            strokeColor: "transparent"

            startX: endLeft ? 0 : seg.pw
            startY: 0

            PathLine {
                x: endRight ? seg.width : isMiddle ? seg.width - seg.pw - 10 : isRight ? seg.width - 20 : isLeft ? seg.width : endLeft ? 30 : 0
                y: 0
            }
            PathLine {
                x: isLeft ? seg.width - 20 : seg.width
                y: seg.height / 2
            }
            PathLine {
                x: endRight ? seg.width : isMiddle ? seg.width - seg.pw - 10 : isRight ? seg.width - 20 : isLeft ? seg.width : endLeft ? 30 : 0
                y: seg.height
            }
            PathLine {
                x: endLeft ? 0 : isRight ? 0 : isMiddle ? seg.pw + 10 : seg.pw + 10
                y: seg.height
            }
            PathLine {
                x: 0 + (isRight ? 20 : 0)
                y: seg.height / 2
            }
            PathLine {
                x: endLeft ? 0 : isRight ? 0 : seg.pw + 10
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
