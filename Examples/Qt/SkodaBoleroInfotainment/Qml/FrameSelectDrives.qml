import QtQuick 2.0

FrameSettings {

    caption: qsTr("Manage files")

    viewLayout.columns: 1

    encoderHighliterEnabled: true

    repeater.model: [
        { imageKeySource: "Images/ImgMenuMedia_64.png", buttonHeight: 65,
            keyCentered: true, eventName: "Drive.CD", eventData: scxmlBolero.driveCD,
            enabled: scxmlBolero.urlDirExists(scxmlBolero.driveCD)
        },

        { imageKeySource: "Images/ImgSDCard.png", buttonHeight: 65,
            keyCentered: true, eventName: "Drive.SD", eventData: scxmlBolero.driveSD,
            enabled: scxmlBolero.urlDirExists(scxmlBolero.driveSD)
        },
        { imageKeySource: "Images/ImgUSB.png", buttonHeight: 65,
            keyCentered: true, eventName: "Drive.USB", eventData: scxmlBolero.driveUSB,
            enabled: scxmlBolero.urlDirExists(scxmlBolero.driveUSB)
        }
    ]
}
