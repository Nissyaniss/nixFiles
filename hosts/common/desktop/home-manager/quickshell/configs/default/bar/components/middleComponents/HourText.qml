import "../../../common/arrows"
import "../../../common"
import "../../components"

MiddleArrow {
    id: root

    required property date date

    BarText {
        text: Qt.formatDateTime(root.date, "hh:mm:ss")
        color: "white"
    }
}
