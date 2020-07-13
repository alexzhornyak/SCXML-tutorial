import QtQuick 2.0
import ScxmlBolero 1.0

Rectangle {
    id: station
    property int stationIndex: -1
    readonly property real frequency: scxmlBolero.getRadioFreq(station.stationIndex)

    Text {
        id: caption
        text: getCaption()
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        function getCaption() {
            if (station.stationIndex!=-1) {
                if (frequency !== 0) {
                    var out = ""
                    if (frequency === 0) {
                        out += qsTr("Empty")
                    }  else {
                        out += "<span style='font-size: 16px;'>"
                        out += frequency.toFixed(scxmlBolero.getRadioPrecision()).toString() + " "
                        out += "</span>"
                        out += "<span style='font-size: 14px;'>"
                        out += scxmlBolero.isRadioFM() ? qsTr("MHz") : qsTr("kHz")
                        out += "</span>"
                    }

                    return out
                }
            }

            return qsTr("Empty")
        }

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        font.family: "Tahoma"
        font.pixelSize: 16
    }


}
