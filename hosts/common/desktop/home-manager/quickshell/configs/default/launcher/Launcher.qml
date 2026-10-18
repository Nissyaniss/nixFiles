import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Widgets
import QtQuick.Controls
import Quickshell.Hyprland
import "../common/arrows"

PanelWindow {
    id: toplevel

    implicitWidth: 600
    implicitHeight: 600
    focusable: true
    color: "transparent"
    visible: false

    function activate(): void {
        toplevel.visible = !toplevel.visible;
        search.text = "";
    }

    Order {
        id: order
    }

    Shortcut {
        sequences: [StandardKey.Cancel]
        context: Qt.ApplicationShortcut
        onActivated: toplevel.visible = false
    }

    HyprlandFocusGrab {
        active: true
        windows: [toplevel]
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
                    const app = list.model.values[list.currentIndex];
                    if (!app)
                        return;
                    order.score(app.name);
                    app.execute();
                    toplevel.visible = false;
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

                        if (search.text.length === 0) {
                            return [...DesktopEntries.applications.values].sort((a, b) => order.frecency(b.name) - order.frecency(a.name) || a.name.localeCompare(b.name));
                        }
                        
                        for (const app of search_result)
                            app.freq = order.frecency(app.name);

                        const query = search.text;

                        for (let query_index = 0; query_index < query.length; query_index++) {
                            let search_result_temp = [];
                            for (let app of search_result) {
                                for (let app_index = 0; app_index < app.name.length; app_index++) {
                                    const char = query[query_index].toLowerCase();
                                    const app_char = app.name[app_index];
                                    const app_char_lower = app_char.toLowerCase();
                                    if (query_index == 0 && app_char_lower == char && app_index == 0) {
                                        app.last_position = 1;
                                        app.score += 10;
                                        search_result_temp.push(app);
                                        break;
                                    } else if (app_index == app.last_position && char == app_char_lower) {
                                        app.consecutive_chars += 1;
                                        app.last_position = app_index + 1;
                                        app.score += app.consecutive_chars * 5;
                                        search_result_temp.push(app);
                                        break;
                                    } else if (app_index >= app.last_position && app_index > 0 && char.toUpperCase() == app_char && (app.name[app_index - 1] == app.name[app_index - 1].toLowerCase() || app.name[app_index - 1] == '-' || app.name[app_index - 1] == '_')) {
                                        app.consecutive_chars = 1;
                                        app.last_position = app_index + 1;
                                        app.score += 4;
                                        search_result_temp.push(app);
                                        break;
                                    } else if (app_index >= app.last_position && app_index > 0 && (app.name[app_index - 1] == '-' || app.name[app_index - 1] == '_' || app.name[app_index - 1] == ' ') && app_char_lower == char) {
                                        app.consecutive_chars = 1;
                                        app.last_position = app_index + 1;
                                        app.score += 3;
                                        search_result_temp.push(app);
                                        break;
                                    } else if (app_index >= app.last_position && app_char_lower == char) {
                                        app.consecutive_chars = 1;
                                        app.last_position = app_index + 1;
                                        search_result_temp.push(app);
                                        break;
                                    }
                                }
                            }

                            search_result = search_result_temp;
                        }
                        const rank = app => app.score + Math.min(app.freq, 15);
                        
                        return search_result.sort((a, b) => rank(b) - rank(a)).map(app => app.entry);
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
                        order.score(modelData.name);
                        modelData.execute();
                        toplevel.visible = false;
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
