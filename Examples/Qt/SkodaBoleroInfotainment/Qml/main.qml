import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import ScxmlBolero 1.0
import QtScxml 5.8
import "Radio"
import "BoleroConstants.js" as Consts

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1397
    height: 743
    color: "#1d1d1d"
    title: qsTr("Infotainment Radio Bolero (Simulator)")

    onClosing: {
        /* we have 2 final states: 'end' and 'fail' */
        /* we will save settings only on 'end' state */
        /* so trigger an event for correct state machine finish */
        scxmlBolero.submitEvent("Inp.Quit")
    }

    ScxmlBolero {
        id: scxmlBolero
        running: true

        function isRadioFM() {
            return scxmlBolero.settings.BandType === "FM"
        }

        function getRadioFreq(index) {
            if (index!==-1) {
                var bandType = scxmlBolero.settings.BandType
                var currentBand = scxmlBolero.settings.Bands[bandType]
                if (currentBand) {
                    var currentFreq = currentBand.Stations[index]["Freq"]
                    if (currentFreq) {
                        return currentFreq
                    }
                }
            }

            return 0
        }

        function getRadioPrecision() {
            return isRadioFM() ? 1 : 0
        }
    }

    MainWidget {
        id: mainWidget
        anchors.centerIn: parent

        FrameRadio {
            id: radio
            parent: mainWidget.container
            visible: scxmlBolero.displayRadio
        }

        Popup {
            id: popupRadioBands
            x: 0
            y: 0
            width: 228
            height: 126
            focus: true
            closePolicy: Popup.NoAutoClose

            ColumnLayout {
                anchors.fill: parent
                SelectButton {
                    Text {
                        anchors.fill: parent
                        text: qsTr("FM")
                    }
                }
                SelectButton {
                    Text {
                        anchors.fill: parent
                        text: qsTr("AM")
                    }
                }
            }

            background: BalloonCanvas {
                id: canvasRadioBands
                anchors.fill: parent
                strokeStyle: Consts.cl_ITEM_BORDER
                fillStyle: Consts.cl_BACKGROUND
            }
       }
    }


}
