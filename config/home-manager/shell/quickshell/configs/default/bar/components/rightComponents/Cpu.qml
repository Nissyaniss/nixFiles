import Quickshell.Io
import QtQuick
import "../../components/arrows"
import "../../components"

LeftArrow {
    id: cpu
    property string usage: "0"
    property int totalT1: 0
    property int totalT2: 0
    property int idleT1: 0
    property int idleT2: 0
    property bool isT1: true

    function updateCpu() {
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "file:///proc/stat", false);
        xhr.send(null);

        if (xhr.status == 200 || xhr.status === 0) {
            let cpuLine = xhr.responseText.split('\n')[0].split(" ");
            let idle = parseInt(cpuLine[5]);
            let total = cpuLine.reduce((accumulator, currentValue) => {
                if (+currentValue && currentValue != "") {
                    return accumulator + parseInt(currentValue);
                } else {
                    return accumulator;
                }
            }, 0);
            if (cpu.isT1) {
                cpu.totalT1 = total;
                cpu.idleT1 = idle;
                cpu.isT1 = false;
            } else {
                cpu.totalT2 = total;
                cpu.idleT2 = idle;
                let totalDelta = cpu.totalT2 - cpu.totalT1;
                let idleTotal = cpu.idleT2 - cpu.idleT1;
                cpu.usage = Math.round((1 - idleTotal / totalDelta) * 100);
                cpu.totalT1 = cpu.totalT2;
                cpu.idleT1 = cpu.idleT2;
            }
        }
    }

    BarText {
        text: `Cpu ${usage}%`
        color: "#6469b5"
    }
}
