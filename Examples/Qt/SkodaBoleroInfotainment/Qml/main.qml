import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.platform 1.0
import ScxmlBolero 1.0
import StorageInfo 1.0
import FileUtils 1.0
import UDPScxmlExternMonitor 1.0
import QtScxml 5.8
import "Radio" as Radio
import "Media" as Media
import "Sound" as Sound
import "System" as System
import "Vehicle" as Vehicle
import "AppConstants.js" as AppConsts
import "qrc:/Model/CommonConstants.js" as Consts

ApplicationWindow {
    id: application
    visible: true
    x: 0
    y: 0
    width: 1920
    height: 1080
    color: "#1d1d1d"
    title: qsTr("Infotainment Radio Bolero (Simulator)")

    onClosing: {
        /* we have 2 final states: 'end' and 'fail' */
        /* we will save settings only on 'end' state */
        /* so trigger an event for correct state machine finish */
        scxmlBolero.submitEvent("Inp.Quit")
    }

    function setRepresentation(ident) {
        if (ident === "Full HD") {
            mainWidget.anchors.verticalCenterOffset = 0
            carBackround.visible = true
            application.width = 1920
            application.height = 1080
        } else if (ident === "HD Ready") {
            mainWidget.anchors.verticalCenterOffset = 0
            carBackround.visible = false
            application.width = 1397
            application.height = 743
        } else if (ident === "VGA") {
            mainWidget.anchors.verticalCenterOffset = 75
            carBackround.visible = false
            application.width = 600
            application.height = 360
        } else {
            console.error("Unknown ident for application representation!", ident)
        }
    }

    SystemTrayIcon {
        visible: true
        iconSource: "qrc:/Qml/Images/ImgCD_32.png"
        tooltip: application.title

        menu: Menu {
            MenuItem {
                text: "Full HD"
                onTriggered: {
                    application.setRepresentation(text)
                    scxmlBolero.submitEvent("Inp.App.UserSettings.AppViewMode", text)
                }
            }

            MenuItem {
                text: "HD Ready"
                onTriggered: {
                    application.setRepresentation(text)
                    scxmlBolero.submitEvent("Inp.App.UserSettings.AppViewMode", text)
                }
            }

            MenuItem {
                text: "VGA"
                onTriggered: {
                    application.setRepresentation(text)
                    scxmlBolero.submitEvent("Inp.App.UserSettings.AppViewMode", text)
                }
            }

            MenuSeparator {
            }

            MenuItem {
                checked: scxmlExternMonitor.scxmlStateMachine != null
                text: "Enable Monitor"
                onTriggered: {
                    scxmlExternMonitor.scxmlStateMachine = scxmlExternMonitor.scxmlStateMachine != null ?
                                null : scxmlBolero
                }
            }

            MenuSeparator {
            }

            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }
        }
    }

    function getStorageRoot(storage) {
            var root = scxmlBolero.getMediaRoot(storage.ident)
            if (root)
                return root

            var index = storageList.indexOf(storage)
            if (index!==-1) {
                var volumes = storage.getMountedVolumes()
                if (volumes.length > index) {
                    return fileUtils.urlFromLocalFile(volumes[index])
                }
            }

        return ""
    }

    /* we assume that drives are fixed in the device */
    StorageInfo {
        id: storageCD

        readonly property string ident: "CD"

        urlPath: getStorageRoot(storageCD)   /* MUST BE REPLACED WITH THE ORIGINAL DEVICE DRIVE PATH */
    }

    StorageInfo {
        id: storageSD

        readonly property string ident: "SD"

        urlPath: getStorageRoot(storageSD)   /* MUST BE REPLACED WITH THE ORIGINAL DEVICE DRIVE PATH */
    }

    StorageInfo {
        id: storageUSB

        readonly property string ident: "USB"

        urlPath: getStorageRoot(storageUSB)  /* MUST BE REPLACED WITH THE ORIGINAL DEVICE DRIVE PATH */
    }

    readonly property var storageList: [
        storageCD,
        storageSD,
        storageUSB
    ]

    FileUtils {
        id: fileUtils
    }

    UDPScxmlExternMonitor {
        id: scxmlExternMonitor
    }

    ScxmlBolero {
        id: scxmlBolero
        running: true

        Component.onCompleted: {
            if (scxmlBolero.settings.UserSettings) {
                if (scxmlBolero.settings.UserSettings.AppViewMode) {
                    application.setRepresentation(scxmlBolero.settings.UserSettings.AppViewMode)
                }
            }
        }

        function getVolume() {
            return scxmlBolero.settings.Volume === undefined ?
                        0.5 : scxmlBolero.settings.Volume
        }

        function getMediaRoot(audio_input) {
            if (settings.Drives && settings.Drives[audio_input] && settings.Drives[audio_input].Root) {
                return settings.Drives[audio_input].Root
            }

            return undefined
        }

        function getCurrentMedia() {
            var audio_input = settings.AudioInput

            if (settings.Drives && settings.Drives[audio_input]) {
                return settings.Drives[audio_input]
            }

            return undefined
        }

        function getCurrentMediaUrl() {
            var obj_media = getCurrentMedia()
            if (obj_media && obj_media.MediaSource)
                return obj_media.MediaSource

            return ""
        }

        function getCurrentMediaRepeatFolderUrl() {
            var obj_media = getCurrentMedia()
            if (obj_media && obj_media.MediaRepeatFolder)
                return obj_media.MediaRepeatFolder

            return ""
        }

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
                pathToImage = fileUtils.urlFromLocalFile(pathToImage)
                if (fileUtils.urlExists(pathToImage)) {
                    return pathToImage
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
                    pathToImage = fileUtils.urlFromLocalFile(pathToImage)
                    if (fileUtils.urlExists(pathToImage))
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
                    fileUtils.fileDelete(pathToImage)
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
                    fileUtils.fileDelete(pathToImage)
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
                    var sourcePath = fileUtils.urlToLocalFile(event.data.url)

                    if (!fileUtils.fileCopy(sourcePath, pathToImage)) {
                        console.error("Can not copy [", sourcePath, "] to [", pathToImage, "]")
                    }
                }
            }
        }
    }

    Media.AudioPlayer {
        id: audioPlayer
    }

    Image {
        id: carBackround

        anchors.centerIn: parent
        anchors.verticalCenterOffset: 175
        anchors.horizontalCenterOffset: -23

        source: "qrc:/Qml/Images/CarBackgound.png"

        fillMode: Image.Pad
    }

    MainWidget {
        id: mainWidget
        anchors.centerIn: parent

        container: [

            BusyIndicator {
                id: busyOnActivate
                anchors.centerIn: parent
                palette.dark: AppConsts.cl_ITEM_BORDER

                height: parent.height / 2
                width: height

                running: scxmlBolero.off_Init
                visible: scxmlBolero.off_Init
            },

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
                    id: radioSelectLogosLoader

                    property url drivePath: ""

                    anchors.fill: parent

                    source: scxmlBolero.radioManageLogosFiles ? "Radio/FrameRadioLogosSelect.qml" : ""

                    EventConnection {
                        stateMachine: scxmlBolero
                        events: ["Inp.App.BtnSetup.Drive.*"]
                        onOccurred: {
                            radioSelectLogosLoader.drivePath = event.data
                        }
                    }
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
                    id: mediaTrackListLoader
                    anchors.fill: parent

                    source: scxmlBolero.displayMedia ? "Media/FrameMediaTrackList.qml" : ""
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
                source: scxmlBolero.displaySoundHandlerBalance ? "Sound/FrameBalanceFader.qml" : ""
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
            /* This is service option only and must be disabled in original device */
            Loader {
                id: selectDriveSourceLoader

                anchors.fill: parent
                source: scxmlBolero.displaySelectDriveSource ? "FrameSelectDriveSource.qml" : ""

                property string driveInput: ""

                EventConnection {
                    stateMachine: scxmlBolero
                    events: ["Inp.App.BtnSetup.System.SelectRoot"]
                    onOccurred: {
                        selectDriveSourceLoader.driveInput = event.data
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
            },
            Loader {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: parent.height/6

                source: scxmlBolero.volumeShow ? "VolumePanel.qml" : ""
            }
        ]
    }
}
