import QtQuick

Canvas {
    id: canvas
    property int activeCirclePart: -1
    property int previousActiveCirclePart: 0
    property int maxCircleParts: 5
    property int listener: canvas.activeCirclePart
    onListenerChanged: canvas.requestPaint()

    function randomRGBA() {
        let r = Math.random();
        let g = Math.random();
        let b = Math.random();
        return Qt.rgba(r, g, b, 0.3);
    }

    function randomCirclePart() {
        let res = Math.floor(Math.random() * maxCircleParts);
        while (res === previousActiveCirclePart) {
            res = Math.floor(Math.random() * maxCircleParts);
        }
        activeCirclePart = res;
    }

    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    width: 500
    height: 500

    onPaint: {
        var ctx = getContext("2d");
        ctx.reset();

        var centerX = width / 2;
        var centerY = height / 2;
        var radius = 200;

        let circlePartLength = 2 / maxCircleParts;
        for (let i = 0; i <= maxCircleParts; i++) {
            if (activeCirclePart == i) {
                ctx.beginPath();
                ctx.arc(centerX, centerY, radius, i == 0 ? 0 : (circlePartLength * i) * Math.PI, (circlePartLength * (i + 1)) * Math.PI);
                ctx.lineWidth = 50;
                ctx.strokeStyle = canvas.randomRGBA();
                ctx.stroke();
            }
        }

        previousActiveCirclePart = activeCirclePart;
    }
}
