import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import ScxmlBolero 1.0
import QtScxml 5.8
import "Radio" as Radio
import "Media" as Media
import "Sound" as Sound
import "System" as System
import "Vehicle" as Vehicle
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

        /* we assume that drives are fixed in the device */
        readonly property string driveCD: "file:///C:/"
        readonly property string driveSD: "file:///D:/"
        readonly property string driveUSB: "file:///F:/"

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

        function getRadioDisplayFreq(d_freq) {
            d_freq = scxmlBolero.bandTypeFM ? d_freq / 1000000 : d_freq / 1000
            return d_freq.toFixed(scxmlBolero.bandTypeFM ? 1 : 0)
        }

        function getRadioCaption(d_freq, s_freqFontSize, s_measureFontSize) {

            if (d_freq !== 0) {
                var out = "<span style='font-size: " + s_freqFontSize + "px;'>"
                out += getRadioDisplayFreq(d_freq) + " "
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

        EventConnection {
            stateMachine: scxmlBolero
            events: ["Out.Radio.CopyLogo"]
            onOccurred: {
                if (event.data) {
                    var iIndex = parseInt(event.data.index)
                    var pathToImage = s_APP_PATH + "/Images/" + scxmlBolero.settings.BandType + "/"
                            + (iIndex + 1).toString() + ".png"
                    var sourcePath = scxmlBolero.urlToLocalFile(event.data.url)

                    if (!scxmlBolero.fileCopy(sourcePath, pathToImage)) {
                        console.error("Can not copy [", sourcePath, "] to [", pathToImage, "]")
                    }
                }
            }
        }
    }

    Media.AudioPlayer {

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
                    source: scxmlBolero.radioDisplaySetupMain ? "Radio/FrameRadioSetup.qml" : ""
                }

                Loader {
                    anchors.fill: parent
                    source: scxmlBolero.radioDisplayAdvancedSetup ? "Radio/FrameRadioSetupAdvanced.qml" : ""
                }

                Loader {
                    anchors.fill: parent
                    sourceComponent: scxmlBolero.radioManagePresets ? radioManagePresetsComponent : undefined

                    Component {
                        id: radioManagePresetsComponent
                        Radio.FrameRadioManageGroup {
                            manageGroupType: Radio.FrameRadioManageGroup.ManageGroupType.Presets
                            contentVisible: scxmlBolero.radioManagePresetsDefault
                        }
                    }
                }

                Loader {
                    anchors.fill: parent
                    sourceComponent: scxmlBolero.radioManageLogos ? radioManageLogosComponent : undefined

                    Component {
                        id: radioManageLogosComponent
                        Radio.FrameRadioManageGroup {
                            manageGroupType: Radio.FrameRadioManageGroup.ManageGroupType.Logos
                            contentVisible: scxmlBolero.radioManageLogosDefault
                        }
                    }
                }

                Loader {
                    id: radioSelectFileLogosLoader
                    anchors.fill: parent                    

                    source: scxmlBolero.radioManageLogosFiles ? "FrameSelectFiles.qml" : ""
                }

                Loader {
                    anchors.fill: parent
                    source: scxmlBolero.radioManageLogosDrives ? "FrameSelectDrives.qml" : ""
                }

                Loader {
                    anchors.fill: parent
                    source: scxmlBolero.radioStationsList ? "Radio/FrameStationList.qml" : ""
                }

                /* Popups */
                Radio.RadioPopupBandsLoader {
                    id: radioPopupBandsLoader
                }
            },
            Media.FrameMedia {
                anchors.fill: parent
                visible: scxmlBolero.displayMedia

                Loader {
                    anchors.fill: parent
                    source: scxmlBolero.mediaTrackList ? "Media/FrameMediaTrackList.qml" : ""
                }

                Loader {
                    anchors.fill: parent
                    source: scxmlBolero.mediaDisplaySetup ? "Media/FrameMediaSetup.qml" : ""
                }

                /* Popups */
                Media.MediaPopupSourceLoader {
                    id: mediaPopupSourceLoader
                }
            },
            Loader {
                anchors.fill: parent
                source: scxmlBolero.displayMenu ? "FrameMenu.qml" : ""
            },
            Loader {
                anchors.fill: parent
                source: scxmlBolero.displayVehicle ? "Vehicle/FrameVehicle.qml" : ""
            },
            Loader {
                id: soundSetupLoader
                anchors.fill: parent
                sourceComponent: scxmlBolero.displaySoundHandlerMain ? soundSetupComponent : undefined

                Component {
                    id: soundSetupComponent
                    Sound.FrameSound {
                        headerBtnBackVisible: !scxmlBolero.displaySound
                    }
                }
            },
            Loader {
                anchors.fill: parent
                source: scxmlBolero.displaySoundHandlerVolume ? "Sound/FrameVolumeSetup.qml" : ""
            },
            Loader {
                anchors.fill: parent
                source: scxmlBolero.displaySoundHandlerMidBassTreble ? "Sound/FrameBassMidTreble.qml" : ""
            },
            Loader {
                anchors.fill: parent
                sourceComponent: scxmlBolero.displaySetupMain ? frameSystemComponent : undefined

                Component {
                    id: frameSystemComponent
                    System.FrameSystem {
                        headerBtnBackVisible: false
                    }
                }
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
