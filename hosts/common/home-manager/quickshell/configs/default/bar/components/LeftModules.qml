import QtQuick
import QtQuick.Layouts
import "./leftComponents"
import "./leftComponents/mprisComponents"

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true
    property bool showMprisPopup: mpris.showMprisPopup
    property int mprisX: mpris.x

    property bool showMixer: mixer.showMixer
    property int mixerX: mixer.x
    Row {
        anchors.verticalCenter: parent.verticalCenter
        padding: 0
        spacing: -5
        PowerButton {}
        HyprlandWorkspaces {}
        Sound {
            id: mixer
        }
        Mpris {
            id: mpris
        }
    }
}
