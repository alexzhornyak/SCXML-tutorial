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

        function getCurrentRadioFreq() {
            var bandType = scxmlBolero.settings.BandType
            var currentBand = scxmlBolero.settings.Bands[bandType]
            if (currentBand) {
                var index = currentBand.Selected

                if (index!=undefined && index!=-1) {
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

        function getCaption(d_freq, s_freqFontSize, s_measureFontSize) {

            if (d_freq !== 0) {
                var out = "<span style='font-size: " + s_freqFontSize + "px;'>"
                out += d_freq.toFixed(scxmlBolero.getRadioPrecision()).toString() + " "
                out += "</span>"
                out += "<span style='font-size: " + s_measureFontSize + "px;'>"
                out += scxmlBolero.isRadioFM() ? qsTr("MHz") : qsTr("kHz")
                out += "</span>"

                return out
            }


            return qsTr("Empty")
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


    }

    Popup {
        id: popupRadioBands
        x: 0
        y: 0
        width: 228
        height: 126
        focus: true
        closePolicy: Popup.NoAutoClose
        modal: true

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
