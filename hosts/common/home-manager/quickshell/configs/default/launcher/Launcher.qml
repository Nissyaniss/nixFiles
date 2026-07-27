import QtQuick
import Quickshell
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick.Controls
import Quickshell.Hyprland
import Quickshell.Io

PanelWindow {
    id: toplevel

    implicitWidth: 600
    implicitHeight: 600
    focusable: true
    color: "transparent"

    Shortcut {
        sequences: [StandardKey.Cancel]
        context: Qt.ApplicationShortcut
        onActivated: Qt.quit()
    }

    HyprlandFocusGrab {
        active: true
        windows: [toplevel]
    }

    FileView {
        id: pop
        path: "/home/nissya/.nixFiles/hosts/common/home-manager/quickshell/configs/default/launcher/.launcher.json"

        watchChanges: true
        onFileChanged: reload()

        property var entries: {
            const apps = DesktopEntries.applications.values;
            const obj = {};
            for (let i = 0; i < apps.length; i++) {
                obj[apps[i].name] = 1;
            }
            return obj;
        }

        onEntriesChanged: setText(JSON.stringify(entries, null, 4))
    }

    DownArrow {
        anchors.fill: parent
        ColumnLayout {
            anchors.fill: parent
            TextField {
                id: search
                focus: true
                color: "white"
                leftPadding: 25
                Component.onCompleted: {
                    forceActiveFocus();
                }
                Layout.fillWidth: true
                Keys.onUpPressed: {
                    list.decrementCurrentIndex();
                }
                Keys.onDownPressed: {
                    list.incrementCurrentIndex();
                }
                Keys.onReturnPressed: {
                    list.model.values[list.currentIndex].execute();
                    Qt.quit();
                }
                background: RightArrow {
                    width: parent.width - 10
                    height: parent.height
                    color: "#666666"
                }
            }
            ListView {
                id: list
                spacing: 15
                currentIndex: 0
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                keyNavigationEnabled: true
                model: ScriptModel {
                    values: {
                        if (search.text.length === 0) {
                            return [...DesktopEntries.applications.values];
                        }

                        class App {
                            constructor(entry) {
                                this.name = entry.name;
                                this.entry = entry;
                                this.last_position = 0;
                                this.score = 0;
                                this.consecutive_chars = 1;
                            }
                        }

                        let search_result = [...DesktopEntries.applications.values].map(entry => new App(entry));
                        const query = search.text;

                        for (let c of query) {
                            let search_result_temp = [];
                            for (let app of search_result) {
                                for (let index = 0; index < app.name.length; index++) {
                                    const char = c.toLowerCase();
                                    const app_char = app.name[index];
                                    const app_char_lower = app_char.toLowerCase();
                                    if (index == 0 && app_char_lower == char) {
                                        app.last_position = 1;
                                        app.score += 10;
                                        search_result_temp.push(app);
                                        break;
                                    } else if (index == app.last_position && char == app_char_lower) {
                                        app.consecutive_chars += 1;
                                        app.last_position = index + 1;
                                        app.score += app.consecutive_chars * 5;
                                        search_result_temp.push(app);
                                        break;
                                    } else if (index >= app.last_position && index > 0 && char.toUpperCase() == app_char && (app.name[index - 1] == app.name[index - 1].toLowerCase() || app.name[index - 1] == '-' || app.name[index - 1] == '_')) {
                                        app.consecutive_chars = 1;
                                        app.last_position = index + 1;
                                        app.score += 4;
                                        search_result_temp.push(app);
                                        break;
                                    } else if (index >= app.last_position && index > 0 && (app.name[index - 1] == '-' || app.name[index - 1] == '_' || app.name[index - 1] == ' ')) {
                                        app.consecutive_chars = 1;
                                        app.last_position = index + 1;
                                        app.score += 3;
                                        search_result_temp.push(app);
                                        break;
                                    } else if (index >= app.last_position && app_char_lower == char) {
                                        app.consecutive_chars = 1;
                                        app.last_position = index + 1;
                                        search_result_temp.push(app);
                                        break;
                                    }
                                }
                            }
                            search_result = search_result_temp;
                        }
                        return search_result.sort((a, b) => b.score - a.score).map(app => app.entry);
                    }
                    onValuesChanged: {
                        if (list.count > 0) {
                            list.currentIndex = 0;
                        }
                    }
                }
                highlight: Item {
                    RightArrow {
                        width: parent.width - 40
                        height: parent.height
                        color: "#666666"
                    }
                }
                delegate: MouseArea {
                    id: delegateRoot
                    implicitHeight: item.implicitHeight
                    implicitWidth: 600
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: false
                    onClicked: {
                        modelData.execute();
                        Qt.quit();
                    }
                    Row {
                        id: item
                        leftPadding: 25
                        IconImage {
                            source: Quickshell.iconPath(modelData.icon)
                            asynchronous: true
                            implicitSize: 30
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Column {
                            leftPadding: 10
                            Text {
                                text: modelData.name
                                color: "white"
                            }
                            Text {
                                text: modelData.comment.length > 90 ? modelData.comment.substring(0, 90) + "..." : modelData.comment
                                font.pixelSize: 10
                                color: "white"
                            }
                        }
                    }
                }
            }
        }
    }
}
