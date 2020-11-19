import QtQuick 2.12
import "../"

FrameSettings {
    caption: qsTr("Media setup")

    viewLayout.columns: 1

    encoderHighliterEnabled: true

    repeater.model: [
        { text: "Sound", eventName: "Media.Sound" },
        { text: "Mix/Repeat/Scan including subfolders",
            eventName: "Media.MixRepeatScan", eventData: { checkName: "MediaDisableSubfolders" },
            showCheckBox: true,
            isChecked: scxmlBolero.settings.MediaDisableSubfolders !== true
        },
        { text: "Traffic programme (TP)", eventName: "Media.Traffic", eventData: { checkName: "RadioTraffic" },
            showCheckBox: true, isChecked: scxmlBolero.settings.RadioTraffic === true,
            enabled: scxmlBolero.settings.RadioRDS === true
        },
        { text: "External AUX device", eventName: "Media.Aux",
            eventData: { checkName: "MediaDisableAux" },
            showCheckBox: true,
            isChecked: scxmlBolero.settings.MediaDisableAux !== true
        }
    ]
}
