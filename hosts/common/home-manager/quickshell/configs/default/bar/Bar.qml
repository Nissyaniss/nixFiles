import Quickshell
import QtQuick.Layouts
import QtQuick
import "./components"

PanelWindow {
    id: topBar
    implicitHeight: 40
    color: "transparent"

    property string openPopup: ""

    readonly property bool showMprisPopup: openPopup == "mpris"
    readonly property bool showMixer: openPopup == "mixer"

    function togglePopup(name: string): void {
        openPopup = openPopup == name ? "" : name;
    }
    property int mprisX: left.mprisX

    property int mixerX: left.mixerX

    anchors {
        top: true
        left: true
        right: true
    }

    MouseArea {
        id: hider
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button == Qt.RightButton && topBar.implicitHeight != 1) {
                topBar.implicitHeight = 1;
                hider.cursorShape = Qt.PointingHandCursor;
            } else if (mouse.button == Qt.RightButton && topBar.implicitHeight == 1) {
                topBar.implicitHeight = 40;
                hider.cursorShape = Qt.ArrowCursor;
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0

        LeftModules {
            id: left
        }

        MiddleModules {}

        RightModules {}
    }
}
