import QtQuick
import Quickshell.Services.Pipewire
import QtQuick.Layouts

import "../components"
import "../../common"

ColumnLayout {
    id: root
    property PwNode node

    PwObjectTracker {
        objects: [root.node]
    }

    BarText {
        text: {
            const app = root.node.properties["application.name"] ?? (root.node.description != "" ? root.node.description : root.node.name);
            const media = root.node.properties["media.name"];
            return media != undefined ? `${app} - ${media}` : app;
        }
    }

    RowLayout {
        BarText {
            Layout.preferredWidth: 50
            text: `${Math.floor(root.node.audio.volume * 100)}%`
        }

        CustomSlider {
            value: root.node.audio.volume
            color: "#6B466D"
            onMoved: root.node.audio.volume = value
        }

        CustomButton {
            text: root.node.audio.muted || root.node.audio.volume == 0 ? "" : ""
            onClicked: root.node.audio.muted = !root.node.audio.muted
        }
    }
}
