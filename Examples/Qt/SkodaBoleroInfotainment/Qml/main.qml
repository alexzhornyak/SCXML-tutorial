import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import ScxmlBolero 1.0
import QtScxml 5.8
import "Radio"
import "AppConstants.js" as AppConsts

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
            if (currentBand && currentBand.CurrentFreq !== undefined) {
                return currentBand.CurrentFreq
            }

            return 0
        }

        function getSelectedRadioFreq() {
            var bandType = scxmlBolero.settings.BandType
            var currentBand = scxmlBolero.settings.Bands[bandType]
            if (currentBand) {
                var index = currentBand.Selected

                if (index !== undefined && index !== -1) {
                    var selectedFreq = currentBand.Stations[index].Freq
                    if (selectedFreq !== undefined) {
                        return selectedFreq
                    }
                }
            }


            return 0
        }

        function getRadioPrecision() {
            return scxmlBolero.bandTypeFM ? 1 : 0
        }

        function getCaption(d_freq, s_freqFontSize, s_measureFontSize) {

            if (d_freq !== 0) {

                d_freq = d_freq.toFixed(scxmlBolero.getRadioPrecision())

                var out = "<span style='font-size: " + s_freqFontSize + "px;'>"
                out += d_freq.toString() + " "
                out += "</span>"
                out += "<span style='font-size: " + s_measureFontSize + "px;'>"
                out += scxmlBolero.bandTypeFM ? qsTr("MHz") : qsTr("kHz")
                out += "</span>"

                return out
            }


            return qsTr("Empty")
        }

        function isRadioStationSelected() {
            return (scxmlBolero.settings.Bands[scxmlBolero.settings.BandType].CurrentFreq > 0) &&
            (scxmlBolero.settings.Bands[scxmlBolero.settings.BandType].Selected === stationIndex && stationIndex !== -1)
        }

        EventConnection {
            stateMachine: scxmlBolero
            events: ["Out.Radio.ScanRequest"]
            onOccurred: {
                scxmlBolero.submitEvent("Inp.App.Radio.Scan.Continue")
            }
        }
    }

    MainWidget {
        id: mainWidget
        anchors.centerIn: parent

        /* we do not use Loader, because frames are loading too slowly */
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
            strokeStyle: AppConsts.cl_ITEM_BORDER
            fillStyle: AppConsts.cl_BACKGROUND
        }
   }
}
