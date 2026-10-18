import "../../../../common"
import QtQuick
import Quickshell.Services.Mpris

Item {
    id: title
    property MprisPlayer mprisPlayer
    width: Math.min(titleText.implicitWidth, 250)
    implicitHeight: titleText.implicitHeight - 6
    clip: true

    ScrollingText {
        id: titleText
        anchors.verticalCenter: parent.verticalCenter
        text: title.mprisPlayer?.trackTitle ?? ""
        font_size: 20
    }
}
