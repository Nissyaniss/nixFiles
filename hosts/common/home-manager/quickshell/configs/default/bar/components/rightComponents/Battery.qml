import "../../components/arrows"
import "../../components"
import Quickshell.Services.UPower
import QtQml.Models

LeftArrow {
    visible: UPower.onBattery

    BarText {
        text: UPower.displayDevice.percentage * 100 + "%"
    }
    Debug {
        to_print: "aaa"
    }
    Instantiator {
        model: UPower.devices
    }
    color: "green"
    width: 110
}
