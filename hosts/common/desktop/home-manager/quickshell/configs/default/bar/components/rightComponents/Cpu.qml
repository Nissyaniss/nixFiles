import QtQuick
import "../../../common/arrows"
import "../../../common"

LeftArrow {
    id: cpu
    property string usage: "0"
    property real totalT1: 0
    property real totalT2: 0
    property real idleT1: 0
    property real idleT2: 0
    property bool isT1: true

    function updateCpu(data) {
        let cpuLine = data.split('\n')[0].split(" ");
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

    BarText {
        text: `Cpu ${usage}%`
        color: "#6469b5"
    }
}
