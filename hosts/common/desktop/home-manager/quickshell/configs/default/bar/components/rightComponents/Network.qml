import "../../../common/arrows"
import "../../../common"

LeftArrow {
    id: network
    property string usage: " 0.0MB/s /  0.0MB/s"
    property real receiveT1: 0
    property real receiveT2: 0
    property real tranmitT1: 0
    property real tranmitT2: 0
    property bool isT1: true

    function updateNetwork(data) {
        let receive = 0;
        let transmit = 0;

        const lines = data.split("\n").slice(2);

        for (const line of lines) {
            const parts = line.trim().split(/[:\s]+/);
            const name = parts[0];

            if (name === "" || name === "lo")
                continue;
            if (name.startsWith("docker") || name.startsWith("br-") || name.startsWith("veth") || name.startsWith("vmnet") || name.startsWith("waydroid"))
                continue;

            receive += Number(parts[1]);
            transmit += Number(parts[9]);
        }
        if (isT1) {
            network.receiveT1 = receive;
            network.tranmitT1 = transmit;
            network.isT1 = false;
            return;
        } else {
            network.receiveT2 = receive;
            network.tranmitT2 = transmit;
        }
        var transmitTotal = ((network.tranmitT2 - network.tranmitT1) * 2 / 1_000_000).toFixed(1);
        var receiveTotal = ((network.receiveT2 - network.receiveT1) * 2 / 1_000_000).toFixed(1);
        network.receiveT1 = network.receiveT2;
        network.tranmitT1 = network.tranmitT2;
        network.usage = ` ${transmitTotal}MB/s /  ${receiveTotal}MB/s`;
    }

    BarText {
        text: usage
        color: "white"
    }
}
