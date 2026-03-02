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
    PwNodeLinkTracker {
        id: linkTracker2
        node: Pipewire.nodes
    }
    ListView {
        id: main

        ComboBox {
            id: control
            width: 200
            model: Pipewire.nodes

            currentIndex: indexOfValue(Pipewire.defaultAudioSink)

            delegate: ItemDelegate {
                id: delegate

                readonly property bool isAudioOutput: modelData.audio && modelData.isSink && !modelData.isStream
                readonly property bool isNotAlreadySelected: modelData != parent.currentValue

                width: control.width

                visible: isAudioOutput && isNotAlreadySelected
                height: visible ? implicitHeight : 0
                contentItem: BarText {
                    text: modelData.name
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
                highlighted: control.highlightedIndex === index
            }

            contentItem: BarText {
                text: parent.currentValue ? (parent.currentValue.description !== "" ? parent.currentValue.description : parent.currentValue.name) : "Select Output"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            popup: Popup {
                y: control.height - 1
                width: control.width
                height: Math.min(contentItem.implicitHeight, control.Window.height - topMargin - bottomMargin)
                padding: 1

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight
                    model: control.popup.visible ? control.delegateModel : null
                    currentIndex: control.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator {}
                }
            }

            onActivated: {
                Pipewire.preferredDefaultAudioSink = currentValue;
            }
        }

        width: 500
        height: count > 1 ? 200 : 100

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

        BarText {
            visible: main.count == 0 ? true : false
            text: "No Apps are playing sounds"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
