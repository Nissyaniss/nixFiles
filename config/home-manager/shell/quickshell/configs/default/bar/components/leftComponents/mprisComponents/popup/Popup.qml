import Quickshell.Widgets
import QtQuick.Effects
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import "../../../../components"
import "./components"

PopupWindow {
    id: musicPopup
    property bool showMusicPopup: false
    property int offset: 50

    color: "transparent"
    anchor.window: topBar
    anchor.rect.x: mpris.x
    anchor.rect.y: mpris.y + 40
    implicitHeight: main.implicitHeight
    visible: showMusicPopup
    implicitWidth: main.implicitWidth + 20

    NumberAnimation on implicitWidth {
        id: openningAnimation
        from: 20
        to: 450
        duration: 300
        easing.type: Easing.InOutQuad
        running: showMusicPopup
    }

    Timer {
        interval: 20
        running: player.isPlaying
        repeat: true
        onTriggered: {
            player.positionChanged();
        }
    }

    PopupBackground {
        id: background
        offset: musicPopup.offset
    }

    Row {
        id: main
        spacing: 10
        topPadding: 10
        bottomPadding: 15

        RecordPlayer {
            rotation: rotation
        }

        Column {
            id: info
            spacing: 10

            MediaTitle {}
            MediaArtist {}
            MediaTime {}
            Seekbar {}
            Controls {}
        }
    }
}
