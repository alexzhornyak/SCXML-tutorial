import QtQuick 2.0
import "../"

FrameSettings {
    caption: qsTr("Sound setup")

    viewLayout.columns: 1

    encoderHighliterEnabled: true

    repeater.model: [
        { text: "Volume", eventName: "Sound.Volume" },
        { text: "Bass - Mid - Treble", eventName: "Sound.BassMidTreble" },
        { text: "Balance - Fader", eventName: "Sound.Balance" },
        { text: "Confirmation tone", eventName: "Sound.ConfirmationTone", eventData: { checkName: "SoundConfirmationTone" },
            showCheckBox: true, isChecked: scxmlBolero.settings.SoundConfirmationTone === true
        }
    ]
}
