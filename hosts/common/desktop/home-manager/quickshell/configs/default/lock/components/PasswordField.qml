import QtQuick
import QtQuick.Controls

TextField {
    id: passwordField
    visible: false
    echoMode: TextInput.Password
    focus: true
    signal requestRespond(message: string)
    signal requestMessageChange(message: string)
    signal requestRestartTimer
    signal requestRandomCirclePart
    signal requestActiveCirclePartChange(activeCirclePart: int)

    onAccepted: {
        if (enabled) {
            requestRespond(text);
            text = "";
            requestMessageChange("Checking...");
        }
    }
    onTextChanged: {
        if (text == "") {
            requestMessageChange("Cleared");
        } else {
            requestMessageChange("");
        }
        requestRestartTimer();
        requestRandomCirclePart();
    }

    Keys.onEscapePressed: event => {
        text = "";
        requestMessageChange("Cleared");
        requestActiveCirclePartChange(-1);
        event.accepted = true;
    }
}
