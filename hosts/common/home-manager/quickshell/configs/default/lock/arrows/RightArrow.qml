import QtQuick
import QtQuick.Shapes

Item {
    id: seg
    default property alias content: contentContainer.data
    property int offset: 20
    property string color: "#1a1a1a"
    property int pw: 12

    width: contentContainer.width + 30 + pw * 2
    height: 40

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4
        ShapePath {
            fillColor: color
            strokeColor: "transparent"

            PathLine {
                x: 0
                y: 0
            }
            PathLine {
                x: offset
                y: seg.height / 2
            }
            PathLine {
                x: 0
                y: seg.height
            }
            PathLine {
                x: if (seg.width - offset < 0) {
                    0;
                } else {
                    seg.width - offset;
                }
                y: seg.height
            }
            PathLine {
                x: if (seg.width < offset) {
                    offset;
                } else {
                    seg.width;
                }
                y: seg.height / 2
            }
            PathLine {
                x: if (seg.width - offset < 0) {
                    0;
                } else {
                    seg.width - offset;
                }
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
