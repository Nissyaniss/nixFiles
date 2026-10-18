import "../../../common/arrows"
import "../../../common"
import "../../components"

RightArrow {
    id: root

    required property date date

    BarText {
        text: Qt.formatDateTime(root.date, "dd/MM")
        color: "white"
    }
}
