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
            pmaText.pamText = "Checking...";
        }
    }
    onTextChanged: {
        if (text == "") {
            pmaText.pamText = "Cleared";
        } else {
            pmaText.pamText = "";
        }
        timer.restart();
        circle.randomCirclePart();
        circle.requestPaint();
    }

    Keys.onEscapePressed: event => {
        text = "";
        pmaText.pamText = "Cleared";
        circle.activeCirclePart = -1;
        event.accepted = true;
    }
}
