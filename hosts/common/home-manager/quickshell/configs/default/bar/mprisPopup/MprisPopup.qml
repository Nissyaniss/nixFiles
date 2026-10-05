import Quickshell.Widgets
import QtQuick.Effects
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import Quickshell.Services.Mpris
import "../components"
import "./components"

Item {
    id: musicPopup
    property bool showMusicPopup: false
    property real progress: showMusicPopup ? 1 : 0
    property int offset: 50
    property MprisPlayer player: null
    property int mprisX

    x: mprisX * progress
    implicitHeight: main.implicitHeight
    visible: showMusicPopup || progressAnim.running
    opacity: Math.max(0, Math.min(1, progress))
    implicitWidth: main.implicitWidth + 20

    Behavior on progress {
        SpringAnimation {
            id: progressAnim
            spring: 10
            damping: 0.5
        }
    }

    Timer {
        interval: 500
        running: player != null && player.isPlaying
        repeat: true
        onTriggered: {
            if (player)
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
