import QtQuick 2.0

FrameSettings {

    caption: qsTr("Manage files")

    viewLayout.columns: 1

    encoderHighliterEnabled: true

    readonly property string driveCD: "file:///C:/"
    readonly property string driveSD: "file:///D:/"
    readonly property string driveUSB: "file:///F:/"

    repeater.model: [
        { imageKeySource: "Images/ImgMenuMedia_64.png", buttonHeight: 65,
            keyCentered: true, eventName: "Drive.CD", eventData: driveCD,
            enabled: scxmlBolero.urlDirExists(driveCD)
        },

        { imageKeySource: "Images/ImgSDCard.png", buttonHeight: 65,
            keyCentered: true, eventName: "Drive.SD", eventData: driveSD,
            enabled: scxmlBolero.urlDirExists(driveSD)
        },
        { imageKeySource: "Images/ImgUSB.png", buttonHeight: 65,
            keyCentered: true, eventName: "Drive.USB", eventData: driveUSB,
            enabled: scxmlBolero.urlDirExists(driveUSB)
        }
    ]
}
