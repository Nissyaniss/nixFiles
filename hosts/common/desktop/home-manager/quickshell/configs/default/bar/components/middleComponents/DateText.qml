import "../../../common/arrows"
import "../../../common"
import "../../components"

LeftArrow {
    id: root

    required property date date

    BarText {
        text: Qt.formatDateTime(root.date, "ddd.")
        color: "white"
    }
}
