import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import "./leftComponents"

Item {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true
    property int mprisX: mpris.x
    signal popupRequested(name: string)
    required property MprisPlayer player

    property int mixerX: mixer.x
    Row {
        anchors.verticalCenter: parent.verticalCenter
        padding: 0
        spacing: -5
        PowerButton {}
        HyprlandWorkspaces {}
        Sound {
            id: mixer
            onPopupRequested: name => {
                root.popupRequested(name);
            }
        }
        Mpris {
            id: mpris
            onPopupRequested: name => {
                root.popupRequested(name);
            }
            player: root.player
        }
    }
}
