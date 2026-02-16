import Quickshell.Io
import QtQuick
import "../../components/arrows"
import "../../components"

LeftArrow {
    property alias running: cpu.running
    property string cpuUsage: "0"

    Process {
        id: cpu
        command: ["python3", "-u", "/home/nissya/.nixFiles/config/home-manager/shell/quickshell/configs/cpu.py"]
        stdout: StdioCollector {
            onStreamFinished: cpuUsage = this.text
        }
    }

    BarText {
        text: `Cpu ${cpuUsage}%`
        color: "#6469b5"
    }
}
