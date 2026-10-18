import "../../../common/arrows"
import "../../../common"
import Quickshell.Services.UPower

LeftArrow {
    visible: UPower.onBattery

    BarText {
        text: Math.round(UPower.displayDevice.percentage * 100) + "%"
    }
    color: "green"
    width: 110
}
