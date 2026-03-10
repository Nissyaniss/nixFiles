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
    implicitHeight: main.height + control.height + 50
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

    Column {
        id: mainColumn
        width: 600
        spacing: 10

        anchors.horizontalCenter: parent.horizontalCenter

        ComboBox {
            id: control
            width: 400
            height: 40
            model: Pipewire.nodes

            currentIndex: indexOfValue(Pipewire.defaultAudioSink)

            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20

            popup: Popup {
                y: control.height
                width: control.width
                implicitHeight: contentItem.implicitHeight
                height: implicitHeight
                padding: 4

                enter: Transition {
                    NumberAnimation {
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 150
                    }
                }

                exit: Transition {
                    NumberAnimation {
                        property: "opacity"
                        from: 1
                        to: 0
                        duration: 150
                    }
                }

                background: Rectangle {
                    color: "#2D2D2D"
                    radius: 8
                    border.color: "#444444"
                    border.width: 1
                }

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight
                    model: control.popup.visible ? control.delegateModel : null
                    currentIndex: control.highlightedIndex
                    spacing: 0
                    boundsBehavior: Flickable.StopAtBounds

                    ScrollIndicator.vertical: ScrollIndicator {}
                }
            }

            indicator: Item {
                width: 20
                height: 20
                anchors.right: parent.right
                anchors.rightMargin: 15
                anchors.verticalCenter: parent.verticalCenter

                BarText {
                    text: "▼"
                    font.pixelSize: 12
                    anchors.centerIn: parent
                }
            }

            background: RightArrow {
                color: "#666666"
                width: control.width
                height: control.height
            }

            delegate: ItemDelegate {
                id: delegate

                readonly property bool isAudioOutput: modelData.audio && modelData.isSink && !modelData.isStream
                readonly property bool isNotAlreadySelected: modelData != control.currentValue

                width: control.popup.width - control.popup.leftPadding - control.popup.rightPadding
                height: 20

                visible: isAudioOutput && isNotAlreadySelected
                clip: true

                topPadding: 0
                bottomPadding: 0
                leftPadding: 0
                rightPadding: 0

                background: Rectangle {
                    color: delegate.highlighted ? "#7A7A7A" : "transparent"
                    radius: 5
                }

                contentItem: BarText {
                    text: modelData.description !== "" ? modelData.description : modelData.name
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 10
                    rightPadding: 10
                    height: 20
                }
                highlighted: control.highlightedIndex === index
            }

            contentItem: BarText {
                text: parent.currentValue ? (parent.currentValue.description !== "" ? parent.currentValue.description : parent.currentValue.name) : "Select Output"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                leftPadding: 15
            }

            onActivated: {
                Pipewire.preferredDefaultAudioSink = currentValue;
            }
        }

        ListView {
            id: main
            width: parent.width
            height: count > 1 ? 200 : 100

            anchors.top: control.bottom
            anchors.topMargin: 10

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
}
