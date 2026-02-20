import QtQuick
import Quickshell.Services.Pipewire
import QtQuick.Controls
import QtQuick.Layouts

import "../../."

ColumnLayout {
    property PwNode node

    PwObjectTracker {
        objects: [node]
    }

    BarText {
        text: {
            const app = node.properties["application.name"] ?? (node.description != "" ? node.description : node.name);
            const media = node.properties["media.name"];
            return media != undefined ? `${app} - ${media}` : app;
        }
    }

    RowLayout {
        BarText {
            Layout.preferredWidth: 50
            text: `${Math.floor(node.audio.volume * 100)}%`
        }

        CustomSlider {
            value: node.audio.volume
            color: "#6B466D"
            onValueChanged: node.audio.volume = value
        }

        CustomButton {
            text: node.audio.muted || node.audio.volume == 0 ? "" : ""
            onClicked: node.audio.muted = !node.audio.muted
        }
    }
}
