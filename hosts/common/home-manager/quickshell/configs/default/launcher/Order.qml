import Quickshell.Io
import Quickshell
import QtQml.Models
import QtQml

FileView {
    path: Quickshell.env("HOME") + "/.local/state/quickshell/order.json"

    watchChanges: true
    onFileChanged: reload()
    onLoadFailed: {
        if (error === FileViewError.FileNotFound)
            writeAdapter();
    }

    function score(name, mode = "normal") {
        if (name in adapter.entries) {
            var entry = adapter.entries[name];
            var last_time = (Date.now() - entry.last) / 36_000_000;
            if (last_time < 1 && mode == "normal" || mode == "hour") {
                entry.score = entry.score * 4;
            } else if (last_time < 24 && mode == "normal" || mode == "day") {
                entry.score = entry.score * 2;
            } else if (last_time < 168 && mode == "normal" || mode == "week") {
                entry.score = entry.score * 0.5;
            } else if (mode == "normal" || mode == "other") {
                entry.score = entry.score * 0.25;
            }
            console.log(JSON.stringify(entry));
            entry.last = Date.now();
            adapter.entries[name] = entry;
            writeAdapter();
        } else {
            adapter.entries[name] = {
                score: 1,
                last: Date.now()
            };
            writeAdapter();
        }
    }

    function frecency(name) {
        if (name in adapter.entries) {
            return adapter.entries[name].score;
        } else {
            return 0;
        }
    }

    JsonAdapter {
        id: adapter
        property var entries: ({})
    }
}
