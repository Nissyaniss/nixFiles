import "../../../../../components/leftComponents/mprisComponents"
import QtQuick

Row {
    spacing: (info.width - background.offset) / 3 - 20
    PreviousButton {
        font.pixelSize: 30
        color: player.canGoPrevious ? "white" : "gray"
        mprisPlayer: player
    }
    PauseButton {
        font.pixelSize: 40
        mprisPlayer: player
        rightPadding: 5
        topPadding: -5
    }
    SkipButton {
        font.pixelSize: 30
        color: player.canGoNext ? "white" : "gray"
        mprisPlayer: player
    }
}
