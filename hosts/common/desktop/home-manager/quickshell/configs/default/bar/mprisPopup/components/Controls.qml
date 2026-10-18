import "../../components/leftComponents/mprisComponents"
import QtQuick
import Quickshell.Services.Mpris

Row {
    id: root
    required property MprisPlayer player

    PreviousButton {
        font.pixelSize: 30
        color: root.player?.canGoPrevious ? "white" : "gray"
        mprisPlayer: root.player
    }
    PauseButton {
        font.pixelSize: 40
        mprisPlayer: root.player
        rightPadding: 5
        topPadding: -5
    }
    SkipButton {
        font.pixelSize: 30
        color: root.player?.canGoNext ? "white" : "gray"
        mprisPlayer: root.player
    }
}
