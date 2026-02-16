import "../../components/arrows"
import "../../components"

MiddleArrow {
    BarText {
        text: Qt.formatDateTime(clock.date, "hh:mm:ss")
        color: "white"
    }
}
