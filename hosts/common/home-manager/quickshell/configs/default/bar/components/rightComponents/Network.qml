import Quickshell.Io
import "../../components/arrows"
import "../../components"

LeftArrow {
    id: network
    property string usage: " 0.0Mb/s /  0.0Mb/s"
    property int receiveT1: 0
    property int receiveT2: 0
    property int tranmitT1: 0
    property int tranmitT2: 0
    property bool isT1: true

    function updateNetwork() {
        let xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState !== XMLHttpRequest.DONE)
                return;
            if (xhr.status !== 200 && xhr.status !== 0)
                return;
            let networkLine = xhr.responseText.split("\n")[4].match(/[^ ]+/g);
            if (!networkLine)
                return;
            let receive = parseInt(networkLine[1]);
            let transmit = parseInt(networkLine[9]);
            if (network.isT1) {
                network.receiveT1 = receive;
                network.tranmitT1 = transmit;
                network.isT1 = false;
            } else {
                network.receiveT2 = receive;
                network.tranmitT2 = transmit;
                var receiveTotal = ((network.receiveT2 - network.receiveT1) / 1_000_000).toFixed(1);
                var transmitTotal = ((network.tranmitT2 - network.tranmitT1) / 1_000_000).toFixed(1);
                network.receiveT1 = network.receiveT2;
                network.tranmitT1 = network.tranmitT2;
                network.usage = ` ${transmitTotal}Mb/s /  ${receiveTotal}Mb/s`;
            }
        };
        xhr.open("GET", "file:///proc/net/dev", true);
        xhr.send(null);
    }

    BarText {
        text: usage
        color: "white"
    }
}
