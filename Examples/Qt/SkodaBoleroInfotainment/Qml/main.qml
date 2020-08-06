import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import ScxmlBolero 1.0
import QtScxml 5.8
import "Radio" as Radio
import "Media" as Media
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

        function getSelectedStation() {
            var bandType = scxmlBolero.settings.BandType
            var currentBand = scxmlBolero.settings.Bands[bandType]
            if (currentBand) {
                return currentBand.Selected
            }
            return -1
        }

        function getRadioFreq(index) {
            if (index!==-1) {
                var bandType = scxmlBolero.settings.BandType
                var currentBand = scxmlBolero.settings.Bands[bandType]
                if (currentBand && currentBand.Presets) {
                    var currentFreq = currentBand.Presets[index]["Freq"]
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
            if (currentBand && currentBand.Presets) {
                var index = currentBand.Selected

                if (index !== undefined && index !== -1) {
                    var selectedFreq = currentBand.Presets[index].Freq
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

        function areRadioPresetsEmpty() {
            var bandType = scxmlBolero.settings.BandType
            var currentBand = scxmlBolero.settings.Bands[bandType]
            if (currentBand && currentBand.Presets) {
                for (var it=0;it<currentBand.Presets.length;it++) {
                    if (currentBand.Presets[it].Freq!==undefined && currentBand.Presets[it].Freq>0) {
                        return false
                    }
                }
            }
            return true
        }

        function getRadioLogosSource(index) {
            if (index !== -1 && scxmlBolero.settings.BandType !== undefined) {
                var pathToImage = s_APP_PATH + "/Images/" + scxmlBolero.settings.BandType + "/"
                        + (index + 1).toString() + ".png"
                if (scxmlBolero.fileExists(pathToImage)) {
                    return "file:///" + pathToImage
                }
            }
            return ""
        }

        function areRadioLogosEmpty() {
            var bandType = scxmlBolero.settings.BandType
            var currentBand = scxmlBolero.settings.Bands[bandType]
            if (currentBand && currentBand.Presets) {
                for (var it=0;it<currentBand.Presets.length;it++) {
                    var pathToImage = s_APP_PATH + "/Images/" + bandType + "/"
                            + (it + 1).toString() + ".png"
                    if (scxmlBolero.fileExists(pathToImage))
                        return false
                }
            }
            return true
        }

        function submitBtnSetupEvent(eventName, eventData) {
            if (eventName!=="") {
                var sEventName = "Inp.App.BtnSetup." + eventName
                if (eventData !== undefined)
                    scxmlBolero.submitEvent(sEventName, eventData)
                else
                    scxmlBolero.submitEvent(sEventName)
            }
        }

        EventConnection {
            stateMachine: scxmlBolero
            events: ["Out.Radio.ScanRequest"]
            onOccurred: {
                // we get here new frequency and require check is there something on it

                /* reserved until radio receiver is used */
                scxmlBolero.submitEvent("Inp.App.Radio.Scan.Continue")
            }
        }

        EventConnection {
            stateMachine: scxmlBolero
            events: ["Out.Radio.DeleteLogo"]
            onOccurred: {
                if (event.data) {
                    var iIndex = parseInt(event.data)
                    var pathToImage = s_APP_PATH + "/Images/" + scxmlBolero.settings.BandType + "/"
                            + (iIndex + 1).toString() + ".png"
                    scxmlBolero.fileDelete(pathToImage)
                }
            }
        }

        EventConnection {
            stateMachine: scxmlBolero
            events: ["Out.Radio.DeleteAllLogos"]
            onOccurred: {
                for (var iIndex=0;iIndex<15;iIndex++) {
                    var pathToImage = s_APP_PATH + "/Images/" + scxmlBolero.settings.BandType + "/"
                            + (iIndex + 1).toString() + ".png"
                    scxmlBolero.fileDelete(pathToImage)
                }

            }
        }
    }

    MainWidget {
        id: mainWidget
        anchors.centerIn: parent

        container: [
            /* we do not use Loader for FrameRadio to display quickly */
            Radio.FrameRadio {
                id: radio
                anchors.fill: parent
                visible: scxmlBolero.displayRadio

                Loader {
                    anchors.fill: parent
                    source: scxmlBolero.radioDisplaySetupMain ? "Radio/FrameRadioSettings.qml" : ""
                }

                Loader {
                    anchors.fill: parent
                    source: scxmlBolero.radioDisplayAdvancedSetup ? "Radio/FrameRadioAdvanced.qml" : ""
                }

                Loader {
                    anchors.fill: parent
                    sourceComponent: scxmlBolero.radioDeletePresets ? radioDeletePresetsComponent : undefined

                    Component {
                        id: radioDeletePresetsComponent
                        Radio.FrameRadioDeleteGroup {
                            deleteGroupType: FrameRadioDeleteGroup.DeleteGroupType.Presets
                            contentVisible: scxmlBolero.radioDeletePresetsDefault
                        }
                    }
                }

                Loader {
                    anchors.fill: parent
                    sourceComponent: scxmlBolero.radioDeleteLogos ? radioDeleteLogosComponent : undefined

                    Component {
                        id: radioDeleteLogosComponent
                        Radio.FrameRadioDeleteGroup {
                            deleteGroupType: FrameRadioDeleteGroup.DeleteGroupType.Logos
                            contentVisible: scxmlBolero.radioDeleteLogosDefault
                        }
                    }
                }

                /* Popups */
                Radio.RadioPopupBandsLoader {
                    id: radioPopupBandsLoader
                }
            },
            Media.FrameMedia {
                anchors.fill: parent
                visible: scxmlBolero.displayMedia
            },
            FrameMenu {
                anchors.fill: parent
                visible: scxmlBolero.displayMenu
            },
            Loader {
                id: confirmDialogLoader

                anchors.fill: parent

                EventConnection {
                    stateMachine: scxmlBolero
                    events: ["Out.ConfirmDialog"]
                    onOccurred: {
                        if (event.data) {
                            confirmDialogLoader.setSource("ConfirmDialog.qml",
                                                          {
                                                              dialogText: event.data.confirmationText,
                                                              dialogModel: event.data.confirmationModel
                                                          })
                        } else {
                            confirmDialogLoader.source = ""
                        }
                    }
                }
            }
        ]
    }
}
