import QtQuick 2.0
import "qrc:/Qml"

FrameSettings {
    caption: qsTr("System setup")

    viewLayout.columns: 1

    encoderHighliterEnabled: true

    repeater.model: [
        { text: "Sound", eventName: "System.Sound" },
        { text: "Screen", eventName: "System.Screen" },
        { text: "Time and date", eventName: "System.DateTime" },
        { text: "Language", eventName: "System.Language" },
        { text: "Keypad:", eventName: "System.Keypad" },
        { text: "More keypad languages", eventName: "System.MoreKeypadLang" },
        { text: "Units", eventName: "System.Units" },
        { text: "Remove SD card 1 safely", eventName: "System.Remove.SD.1" },
        { text: "Remove USB device safely", eventName: "System.Remove.USB" },
        { text: "Factory settings", eventName: "System.FactorySettings" },
        { text: "Bluetooth", eventName: "System.Bluetooth" },
        { text: "System information", eventName: "System.Sysinfo" },
        { text: "Copyright", eventName: "System.Copyright" }
    ]
}
