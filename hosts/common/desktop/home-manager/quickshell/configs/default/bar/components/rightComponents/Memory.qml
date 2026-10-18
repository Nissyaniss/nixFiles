import QtQuick
import "../../../common/arrows"
import "../../../common"

LeftArrow {
    id: mem
    property string memUsage: "0"

    function updateMemory(data) {
        let lines = data.split('\n');
        let total = 0;
        let available = 0;

        for (let i = 0; i < lines.length; i++) {
            if (lines[i].indexOf("MemTotal:") === 0) {
                total = parseInt(lines[i].replace(/[^0-9]/g, ''));
            } else if (lines[i].indexOf("MemAvailable:") === 0) {
                available = parseInt(lines[i].replace(/[^0-9]/g, ''));
            }
        }

        if (total > 0) {
            let percentage = Math.round(((total - available) / total) * 100);
            mem.memUsage = percentage;
        }
    }

    BarText {
        text: `Mem ${mem.memUsage}%`
        color: "#017a7a"
    }
}
