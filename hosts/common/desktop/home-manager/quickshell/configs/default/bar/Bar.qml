import Quickshell
import QtQuick.Layouts
import QtQuick
import Quickshell.Services.Mpris
import "./components"

PanelWindow {
    id: topBar
    implicitHeight: 40
    color: "transparent"

    property string openPopup: ""

    readonly property bool showMprisPopup: openPopup == "mpris"
    readonly property bool showMixer: openPopup == "mixer"
    required property MprisPlayer player

    property int mprisX: left.mprisX

    property int mixerX: left.mixerX

    Timer {
        interval: 500
        running: topBar.player != null && topBar.player.isPlaying
        repeat: true
        onTriggered: {
            if (topBar.player)
                topBar.player.positionChanged();
        }
    }

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
            onPopupRequested: name => {
                if (name == topBar.openPopup) {
                    topBar.openPopup = "";
                } else {
                    topBar.openPopup = name;
                }
            }
            player: topBar.player
        }

        MiddleModules {}

        RightModules {
            topbarRef: topBar
        }
    }
}
