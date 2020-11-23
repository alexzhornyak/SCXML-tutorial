import QtQuick 2.0

FrameSettings {

    caption: qsTr("Manage files")

    viewLayout.columns: 1

    encoderHighliterEnabled: true

    repeater.model: [
        { imageKeySource: "Images/ImgMenuMedia_64.png", buttonHeight: 65,
            keyCentered: true, eventName: "Drive.CD", eventData: storageCD.urlPath,
            enabled: storageCD.enabled
        },
        { imageKeySource: "Images/ImgSDCard.png", buttonHeight: 65,
            keyCentered: true, eventName: "Drive.SD", eventData: storageSD.urlPath,
            enabled: storageSD.enabled
        },
        { imageKeySource: "Images/ImgUSB.png", buttonHeight: 65,
            keyCentered: true, eventName: "Drive.USB", eventData: storageUSB.urlPath,
            enabled: storageUSB.enabled
        }
    ]
}
