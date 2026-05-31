import "../../components/arrows"
import "../../components"

LeftArrow {
    BarText {
        text: Qt.formatDateTime(clock.date, "ddd.")
        color: "white"
    }
}
