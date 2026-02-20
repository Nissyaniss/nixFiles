import Quickshell.Widgets
import QtQuick.Effects
import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import "../../../components"
import "../../../components/arrows"
import "./."

PopupWindow {
    id: soundMixer
    property bool showMixer: false
    property int offset: 50

    color: "transparent"
    anchor.window: topBar
    implicitHeight: main.height + 10
    implicitWidth: main.width + 20
    anchor.rect.x: sound.x
    anchor.rect.y: sound.y + 40
    visible: showMixer

    PopupBackground {
        offset: 20
    }

    PwNodeLinkTracker {
        id: linkTracker
        node: Pipewire.defaultAudioSink
    }

    ListView {
        id: main
        width: 500
        height: 200

        clip: true
        spacing: 10

        topMargin: 20
        bottomMargin: 20
        leftMargin: 20
        rightMargin: 20

        model: linkTracker.linkGroups

        delegate: SoundMixerEntry {
            required property PwLinkGroup modelData
            width: ListView.view.width - ListView.view.leftMargin - ListView.view.rightMargin
            node: modelData.source
        }
    }
}
