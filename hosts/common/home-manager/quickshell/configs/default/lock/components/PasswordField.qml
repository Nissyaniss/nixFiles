import QtQuick
import QtQuick.Controls

TextField {
    id: passwordField
    visible: false
    echoMode: TextInput.Password
    focus: true

    enabled: pamContext.responseRequired

    onAccepted: {
        if (pamContext.responseRequired) {
            pamContext.respond(text);
            text = "";
            pamText.pamText = "Checking...";
        }
    }
    onTextChanged: {
        if (text == "") {
            pamText.pamText = "Cleared";
        } else {
            pamText.pamText = "";
        }
        timer.restart();
        circle.randomCirclePart();
        circle.requestPaint();
    }

    Keys.onEscapePressed: event => {
        text = "";
        pamText.pamText = "Cleared";
        circle.activeCirclePart = -1;
        event.accepted = true;
    }
}
