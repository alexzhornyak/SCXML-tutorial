import QtQuick 2.12
import QtQuick.Layouts 1.12
import ScxmlBolero 1.0
import "../"
import "../BoleroConstants.js" as Consts

SelectButton {
    id: station

    gradientColor: image.source ? "#80ffffff" : "white"

    onPressedChanged: scxmlBolero.submitEvent("Inp.App.Radio.Station." + stationIndex,
                                              pressed ? 1 : 0)
    itemSelected: scxmlBolero.settings.Bands[scxmlBolero.settings.BandType].Selected === stationIndex && stationIndex !== -1

    property int stationIndex: -1
    readonly property real frequency: scxmlBolero.getRadioFreq(station.stationIndex)    

    Text {
        id: numberText
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 8
        text: station.stationIndex + 1
        color: Consts.cl_ITEM_TEXT
        style: Text.Outline
        font.family: "Tahoma"
        font.pixelSize: 16
        // visible: frequency !== 0
    }

    Image {
        id: image
        anchors.centerIn: parent
        width: station.width / 1.5
        height: station.height / 1.5
        antialiasing: true

        function getImageSource() {
//            var imgSource = station.stationIndex

//            if (imgSource!=undefined) {
//                console.warn(Qt.resolvedUrl(imgSource))
//                return imgSource
//            }

            return "file:///f:/RadioLogo/101_7_lux-fm.png"
        }

        source: getImageSource()
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: caption
        text: scxmlBolero.getCaption(station.frequency, "16", "14")
        textFormat: Text.RichText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3

        color: Consts.cl_ITEM_TEXT
        style: Text.Outline
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        font.family: "Tahoma"
        font.pixelSize: 16
    }
}
