import QtQuick 2.12
import QtQuick.Layouts 1.12
import ScxmlBolero 1.0
import "../"
import "../AppConstants.js" as AppConsts

SelectButton {
    id: station

    gradientColor: image.source ? "#80ffffff" : "white"

    property real mousePressedX: 0
    property real mousePressedY: 0

    property int stationIndex: 0
    readonly property real frequency: scxmlBolero.getRadioFreq(station.stationIndex)

    Text {
        id: numberText
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 8
        text: station.stationIndex + 1
        color: AppConsts.cl_ITEM_TEXT
        style: Text.Outline
        font.family: "Tahoma"
        font.pixelSize: 16
        visible: image.source == ""
    }

    Image {
        id: image
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -caption.height / 2
        width: station.width / 1.2
        height: station.height / 1.2
        antialiasing: true

        function getImageSource() {

            if (station.stationIndex != -1 && scxmlBolero.settings.BandType !== undefined) {
                var pathToImage = s_APP_PATH + "/Images/" + scxmlBolero.settings.BandType + "/"
                        + (station.stationIndex + 1).toString() + ".png"
                if (scxmlBolero.fileExists(pathToImage)) {
                    return "file:///" + pathToImage
                }
            }

            return ""
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

        color: AppConsts.cl_ITEM_TEXT
        style: Text.Outline
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        font.family: "Tahoma"
        font.pixelSize: 16
    }
}
