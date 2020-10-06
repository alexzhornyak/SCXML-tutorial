import QtQuick 2.0

FrameSettings {

    caption: qsTr("Manage files")

    viewLayout.columns: 1

    encoderHighliterEnabled: true

    repeater.model: [
        { imageKeySource: "Images/ImgMenuMedia_64.png", buttonHeight: 65,
            keyCentered: true, eventName: "Drive.CD",
            enabled: false
        },

        { imageKeySource: "Images/ImgSDCard.png", buttonHeight: 65,
            keyCentered: true, eventName: "Drive.SD", eventData: "file:///c:" },

        { imageKeySource: "Images/ImgUSB.png", buttonHeight: 65,
            keyCentered: true, eventName: "Drive.USB",
            enabled: false
        }
    ]
}
