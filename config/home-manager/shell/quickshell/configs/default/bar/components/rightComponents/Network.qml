import Quickshell.Io
import "../../components/arrows"
import "../../components"

LeftArrow {
    property alias running: network.running
    property string networkUsage: " 0.0Mb/s /  0.0Mb/s"

    Process {
        id: network
        command: ["python3", "-u", "/home/nissya/.nixFiles/config/home-manager/shell/quickshell/configs/network.py"] // need to change this
        stdout: StdioCollector {
            onStreamFinished: networkUsage = this.text
        }
    }

    BarText {
        text: networkUsage
        color: "white"
    }
}
