import "../../../common"
import QtQuick
import Quickshell.Services.Mpris

CustomSlider {
    id: slider

    required property MprisPlayer player

    to: player?.length ?? 0

    Connections {
        target: slider.player
        function onPositionChanged() {
            if (!slider.pressed) {
                slider.value = slider.player.position;
            }
        }
    }

    onPressedChanged: {
        if (!pressed) {
            player.position = value;
        }
    }
}
