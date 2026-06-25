import Quickshell.Services.Pam
import Quickshell
import "../"

PamContext {
    id: pamContext
    config: "quickshell"

    onCompleted: result => {
        if (result === PamResult.Success) {
            LockState.locked = false;
            Qt.quit();
        } else {
            pamText.pamText = "Failed";
            pamContext.start();
        }
    }
}
