import Quickshell.Io
import Quickshell
import QtQml

FileView {
    path: Quickshell.env("HOME") + "/.local/state/quickshell/order.json"

    watchChanges: true
    onFileChanged: reload()
    onLoadFailed: function (error) {
        if (error === FileViewError.FileNotFound)
            writeAdapter();
    }

    function score(name) {
        if (name in adapter.entries) {
            var entry = adapter.entries[name];
            entry.time_open += 1;
            entry.last = Date.now();
            adapter.entries[name] = entry;
            writeAdapter();
        } else {
            adapter.entries[name] = {
                time_open: 1,
                last: Date.now()
            };
            writeAdapter();
        }
    }

    function frecency(name) {
        if (name in adapter.entries) {
            var entry = adapter.entries[name];
            var last_time = (Date.now() - entry.last) / 3_600_000;
            var score = 0;

            if (last_time < 1) {
                score = entry.time_open * 4;
            } else if (last_time < 24) {
                score = entry.time_open * 2;
            } else if (last_time < 168) {
                score = entry.time_open * 0.5;
            } else {
                score = entry.time_open * 0.25;
            }
            return score;
        } else {
            return 0;
        }
    }

    JsonAdapter {
        id: adapter
        property var entries: ({})
    }
}
