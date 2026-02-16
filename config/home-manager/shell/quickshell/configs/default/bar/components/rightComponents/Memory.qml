import Quickshell.Io
import "../../components/arrows"
import "../../components"

LeftArrow {
    property alias running: mem.running
    property string memUsage: "0"

    Process {
        id: mem
        command: ["nu", "-c", "(((sys mem).used / (sys mem).total) * 100 | math round | into string)"]
        stdout: StdioCollector {
            onStreamFinished: memUsage = this.text.trim()
        }
    }

    BarText {
        text: `Mem ${memUsage}%`
        color: "#017a7a"
    }
}
