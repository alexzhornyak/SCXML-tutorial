import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../BoleroConstants.js" as Consts

Item {
    id: bottomPanel

    RowLayout {
        id: rowButtons
        anchors.fill: parent
        spacing: 3

        clip: true

        Repeater {
            id: repeaterButtons
            model: [    { name: "Band" }, //special case: 'FM' or 'AM' text
                        { name: "Stations", img: "../Images/RadioStations.png" },
                        { name: "Manual", img: "../Images/RadioManual.png" },
                        { name: "Setup", img: "../Images/ImgBtnSettings.png"}
            ]

            delegate: FocusButton {
                name: modelData.name
                text: qsTr(modelData.name)
                imageSource: index!=0 ? modelData.img : imageSource
                imageVisible: index!=0
            }
        }
    }
}


