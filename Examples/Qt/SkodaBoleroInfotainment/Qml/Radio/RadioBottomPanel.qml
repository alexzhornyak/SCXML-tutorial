import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "qrc:/Qml"

Item {
    id: bottomPanel

    RowLayout {
        id: rowButtons
        anchors.fill: parent
        spacing: 3

        clip: true

        Repeater {
            id: repeaterButtons
            model: [    { name: "Band", caption: scxmlBolero.bandTypeFM ? "FM" : "AM" /* untranslatable */ },
                        { name: "Stations", img: "qrc:/Qml/Images/RadioStations.png" },
                        { name: "Manual", img: "qrc:/Qml/Images/RadioManual.png" },
                        { name: "Setup", img: "qrc:/Qml/Images/ImgBtnSettings.png"}
            ]

            delegate: FocusButton {
                id: focusBtn
                topBorderVisible: scxmlBolero.radioAccentOn
                footerText: qsTr(modelData.name)
                imgSource: modelData.img ? modelData.img : ""
                btnCaption: modelData.caption ? modelData.caption : ""

                onClicked: {
                    if (modelData.name === "Band") {
                        var coordinates = focusBtn.mapToItem(radioPopupBandsLoader.parent, 0, -radioPopupBandsLoader.height)
                        radioPopupBandsLoader.popupX = coordinates.x + focusBtn.width/2;
                        radioPopupBandsLoader.popupY = coordinates.y;
                    }
                    scxmlBolero.submitEvent("Inp.App.Radio.Btn." + modelData.name)
                }
            }
        }
    }
}


