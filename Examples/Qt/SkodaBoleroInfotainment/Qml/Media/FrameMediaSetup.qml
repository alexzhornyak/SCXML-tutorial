import QtQuick 2.12
import "../"

FrameSettings {
    caption: qsTr("Media setup")

    viewLayout.columns: 1

    encoderHighliterEnabled: true

    repeater.model: [
        { text: "Sound", eventName: "Media.Sound" },
        { text: "Mix/repeat/Scan", eventName: "Media.MixRepeatScan" },
        { text: "Traffic programme (TP)", eventName: "Media.TrafficProgram" },
        { text: "External AUX device", eventName: "Media.Aux" }
    ]
}
