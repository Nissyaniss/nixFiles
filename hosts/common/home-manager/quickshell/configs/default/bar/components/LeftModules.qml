import QtQuick
import QtQuick.Layouts
import "./leftComponents"
import "./leftComponents/mprisComponents"

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true
    Row {
        anchors.verticalCenter: parent.verticalCenter
        padding: 0
        spacing: -5
        PowerButton {}
        HyprlandWorkspaces {}
        Sound {}
        Mpris {}
    }
}
