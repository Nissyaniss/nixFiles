import QtQuick
import Quickshell.Services.Mpris
import "../../components"
import "../../../common"

Item {
    id: title
    required property MprisPlayer player
    required property int info_width

    width: Math.min(titleText.implicitWidth, info_width - 40)
    implicitHeight: titleText.implicitHeight - 6
    clip: true

    ScrollingText {
        id: titleText
        anchors.verticalCenter: parent.verticalCenter
        maxWidth: title.info_width - 40
        text: title.player?.trackTitle ?? ""
        font_size: 20
    }
}
