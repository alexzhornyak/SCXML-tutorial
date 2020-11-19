import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts

Item {
    id: bottomPanel

    RowLayout {
        id: rowButtons
        anchors.fill: parent
        spacing: 3

        clip: true

        Repeater {
            id: repeaterButtons

            function getMediaSourceImage() {
                if (scxmlBolero.audioInputCD)
                    return "qrc:/Qml/Images/ImgCD_32.png"
                if (scxmlBolero.audioInputSD)
                    return "qrc:/Qml/Images/ImgSD_32.png"
                if (scxmlBolero.audioInputUSB)
                    return "qrc:/Qml/Images/ImgUSB_32.png"
                if (scxmlBolero.audioInputAUX)
                    return "qrc:/Qml/Images/ImgAUX_32.png"

                return "" // mustn't occur
            }

            model: [
                { name: "Source", enabled: true, img: getMediaSourceImage() },
                { name: "Selection", enabled: scxmlBolero.mediaPlayerNormal, img: "qrc:/Qml/Images/ImgTrackList_32.png" },
                { name: "Setup", enabled: true, img: "qrc:/Qml/Images/ImgBtnSettings.png"}
            ]

            delegate: FocusButton {
                id: focusBtn
                topBorderVisible: scxmlBolero.mediaAccentOn
                footerText: qsTr(modelData.name)
                imgSource: modelData.img ? modelData.img : ""
                btnCaption: modelData.caption ? modelData.caption : ""
                enabled: modelData.enabled

                onClicked: {
                    if (modelData.name === "Source") {
                        var coordinates = focusBtn.mapToItem(mediaPopupSourceLoader.parent, 0, -mediaPopupSourceLoader.height)
                        mediaPopupSourceLoader.popupX = coordinates.x + focusBtn.width/2;
                        mediaPopupSourceLoader.popupY = coordinates.y;
                    }
                    scxmlBolero.submitEvent("Inp.App.Media.Btn." + modelData.name)
                }
            }
        }
    }
}
