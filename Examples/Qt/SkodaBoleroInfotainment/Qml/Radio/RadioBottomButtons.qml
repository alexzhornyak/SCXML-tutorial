import QtQuick 2.8
import QtQuick.Controls 2.2

Row {
    id: rowButtons

    clip: true

    Repeater {
        id: repeaterButtons
        model: [    { text: qsTr("Band") }, //special case: 'FM' or 'AM' text
                    { text: qsTr("Stations"), img: "../Images/RadioStations.png" },
                    { text: qsTr("Manual"), img: "../Images/RadioManual.png" },
                    { text: qsTr("Setup"), img: "../Images/ImgBtnSettings.png"}
        ]

        delegate: FocusButton {
            text: modelData.text
            imageSource: index!=0 ? modelData.img : imageSource
            imageVisible: index!=0
            width: rowButtons.width / repeaterButtons.model.length - (paneRadio.i_ROW_SPACING - (paneRadio.i_ROW_SPACING/repeaterButtons.model.length) )
            height: rowButtons.height
//            sensorEnter: {
//                for (var i=0;i<repeaterButtons.count;i++) {
//                    if (repeaterButtons.itemAt(i).hovered)
//                        return true
//                }
//                return false
//            }
        }
    }
}
