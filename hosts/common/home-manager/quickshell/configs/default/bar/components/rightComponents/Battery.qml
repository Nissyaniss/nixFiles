import "../../components/arrows"
import "../../components"
import Quickshell.Services.UPower
import QtQml.Models

LeftArrow {
    visible: UPower.onBattery

    BarText {
        text: UPower.displayDevice.percentage * 100 + "%"
    }
    Instantiator {
        model: UPower.devices
    }
    color: "green"
    width: 110
}
