import QtQuick 2.12
import "qrc:/Qml"

FrameSettings {
    caption: qsTr("Volume setup")

    viewLayout.columns: 1

    encoderHighliterEnabled: true

    repeater.model: [
        { text: "Announcements", eventName: "Volume.Announcements" },
        { text: "Maximum switch-on volume", eventName: "Volume.MaxSwitchOn" },
        { text: "Volume adjustment", eventName: "Volume.Adjustment" },
        { text: "Aux volume", eventName: "Volume.Aux" }
    ]
}
