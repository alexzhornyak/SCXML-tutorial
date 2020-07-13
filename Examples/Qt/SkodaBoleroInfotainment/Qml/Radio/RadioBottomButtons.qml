import QtQuick 2.8
import QtQuick.Controls 2.2

Row {
    id: rowButtons

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
            width: rowButtons.width / repeaterButtons.model.length - (paneRadio.i_ROW_SPACING - (paneRadio.i_ROW_SPACING/repeaterButtons.model.length) )
            height: rowButtons.height
        }
    }
}
