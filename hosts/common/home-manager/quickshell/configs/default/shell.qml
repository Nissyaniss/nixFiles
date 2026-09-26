//@ pragma UseQApplication
import "./bar"
import "./launcher"
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

ShellRoot {
    Bar {}
    Launcher {
        id: launcher
    }
    IpcHandler {
        target: "launcher"
        function activate(): void {
            launcher.activate();
        }
    }
}
