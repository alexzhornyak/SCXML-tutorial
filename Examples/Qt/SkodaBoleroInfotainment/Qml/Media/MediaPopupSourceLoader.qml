import QtQuick 2.0
import "qrc:/Qml"

Loader {
    id: popupLoader

    property real popupX: 0
    property real popupY: 0

    property real offsetX: 0
    property real offsetY: 0

    x: popupX + offsetX
    y: popupY + offsetY

    width: 440
    height: 126

    sourceComponent: scxmlBolero.mediaPopupSource ? popupComponent : undefined

    Component {
        id: popupComponent
        BalloonPopup {
            id: balloon
            balloonDirection: BalloonCanvas.BalloonDirection.Bottom
            eventName: "Media.SourceType"

            model: [
                { text: "CD", eventData: "CD", enabled: scxmlBolero.driveSourceCD_On,
                    imageKeySource: "qrc:/Qml/Images/ImgCD_32.png",
                    keyCentered: false, col:0 },
                { text: "SD", eventData: "SD", enabled: scxmlBolero.driveSourceSD_On,
                    imageKeySource: "qrc:/Qml/Images/ImgSD1_32.png",
                    keyCentered: false, col: 1 },
                { text: "USB", eventData: "USB", enabled: scxmlBolero.driveSourceUSB_On,
                    imageKeySource: "qrc:/Qml/Images/ImgUSB_32.png",
                    keyCentered: false, col: 0, row: 1 },
                { text: "AUX", eventData: "AUX", imageKeySource: "qrc:/Qml/Images/ImgAUX_32.png",
                    enabled: scxmlBolero.settings.MediaDisableAux!==true,
                    keyCentered: false, col: 1, row: 1 }
            ]

            Component.onCompleted: {
                popupLoader.offsetX = -1.0 * (balloon.triangleOffset + balloon.triangleEdge + balloon.lineWidth)
            }
        }
    }
}
