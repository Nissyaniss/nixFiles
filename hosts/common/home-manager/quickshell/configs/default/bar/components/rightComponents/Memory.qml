import Quickshell.Io
import QtQuick
import QtQuick.Controls
import "../../components/arrows"
import "../../components"

LeftArrow {
    id: mem
    property string memUsage: "0"

    function updateMemory() {
        let xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState !== XMLHttpRequest.DONE) return;
            if (xhr.status !== 200 && xhr.status !== 0) return;
            let lines = xhr.responseText.split('\n');
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
        };
        xhr.open("GET", "file:///proc/meminfo", true);
        xhr.send(null);
    }

    BarText {
        text: `Mem ${mem.memUsage}%`
        color: "#017a7a"
    }
}
