import Quickshell.Services.Pam

PamContext {
    id: pamContext
    config: "quickshell"
    signal requestLock
    signal requestMessageChange(message: string)

    onCompleted: result => {
        if (result === PamResult.Success) {
            requestLock();
        } else {
            requestMessageChange("Failed");
            pamContext.start();
        }
    }
}
