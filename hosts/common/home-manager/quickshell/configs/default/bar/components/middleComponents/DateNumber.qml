import "../../components/arrows"
import "../../components"

RightArrow {
    BarText {
        text: Qt.formatDateTime(clock.date, "dd/MM")
        color: "white"
    }
}
