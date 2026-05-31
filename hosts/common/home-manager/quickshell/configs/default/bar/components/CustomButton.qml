import QtQuick
import "./."
import "./arrows"

Item {
    id: root

    property bool isHovered: false

    implicitWidth: buttonText.implicitWidth + 50
    implicitHeight: buttonText.implicitHeight + 10

    signal clicked
    property alias text: buttonText.text

    RightArrow {
        id: arrow
        color: isHovered ? "#7A7A7A" : "#666666"
        anchors.fill: parent

        BarText {
            id: buttonText
            anchors.centerIn: parent
            text: root.text
        }
    }

    MouseArea {
        id: mouse
        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            root.clicked();
        }
        onEntered: {
            isHovered = true;
        }
        onExited: {
            isHovered = false;
        }
    }
}
