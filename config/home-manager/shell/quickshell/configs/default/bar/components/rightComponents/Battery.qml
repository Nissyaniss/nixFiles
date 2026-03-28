import "../../components/arrows"
import "../../components"
import Quickshell.Services.UPower
import QtQml.Models

LeftArrow {
    BarText {
        text: UPower.displayDevice.percentage + "%"
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
