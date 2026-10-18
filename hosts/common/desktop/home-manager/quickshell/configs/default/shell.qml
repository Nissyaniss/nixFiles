//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire
import "./bar"
import "./bar/mprisPopup"
import "./bar/soundMixer"
import "./launcher"
import "./notifications"
import "./lock"

PanelWindow {
    id: shell

    readonly property list<MprisPlayer> availablePlayers: Mpris.players.values
    property MprisPlayer player: availablePlayers.find(p => p.isPlaying) ?? availablePlayers.find(p => p.canControl && p.canPlay) ?? null

    PwNodeLinkTracker {
        id: pipewireLinkTracker
        node: Pipewire.defaultAudioSink
    }

    Notification {}

    color: "transparent"
    anchors {
        left: true
        bottom: true
        right: true
        top: true
    }

    mask: Region {
        Region {
            x: bar.mprisX
            y: mprisPopup.y
            width: bar.showMprisPopup ? mprisPopup.width : 0
            height: bar.showMprisPopup ? mprisPopup.height : 0
        }

        Region {
            x: bar.mixerX
            y: soundMixerPopup.y
            width: bar.showMixer ? soundMixerPopup.width : 0
            height: bar.showMixer ? soundMixerPopup.height : 0
        }
    }

    Bar {
        id: bar
        player: shell.player
    }

    SoundMixer {
        id: soundMixerPopup
        linkTracker: pipewireLinkTracker
        mixerX: bar.mixerX
        showMixer: bar.showMixer
    }

    MprisPopup {
        id: mprisPopup
        player: shell.player
        mprisX: bar.mprisX
        showMusicPopup: bar.showMprisPopup
    }

    Launcher {
        id: launcher
    }

    IpcHandler {
        target: "shell"
        function launcherActivate(): void {
            launcher.activate();
        }
        function lockActivate(): void {
            lock.activate();
        }
    }

    Lock {
        id: lock
    }
}
