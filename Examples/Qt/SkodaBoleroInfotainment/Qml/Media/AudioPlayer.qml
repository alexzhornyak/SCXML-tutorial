import QtQuick 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import Qt.labs.folderlistmodel 2.12
import ScxmlBolero 1.0
import QtScxml 5.8
import "../"
import "qrc:/Model/CommonConstants.js" as Consts

Item {
    id: name

    Connections {
        target: scxmlBolero

        function onMediaScanCompleted(sUrl, outList) {

            var playlist = undefined
            var source = undefined

            audio.playlist = null

            if (sUrl===scxmlBolero.driveCD) {
                playlist = playlistCD
                source = "CD"
            } else if (sUrl===scxmlBolero.driveSD) {
                playlist = playlistSD
                source = "SD"
            } else if (sUrl===scxmlBolero.driveUSB) {
                playlist = playlistUSB
                source = "USB"
            } else {
                console.error("Undefined media url:", sUrl)
            }

            if (playlist) {
                for (var file of outList) {
                    playlist.addItem(Qt.resolvedUrl(file))
                }

                scxmlBolero.submitEvent("Inp.App.Media.DriveScanned." + source);
            }
        }
    }

    Audio {
        id: audio
    }

    Playlist {
        id: playlistCD

        property bool enabled: scxmlBolero.driveSourceCD_On

        onEnabledChanged: {
            this.clear()

            if (enabled) {
                scxmlBolero.scanDirAsync(scxmlBolero.driveCD, Consts.t_MEDIA_AVAILABLE_EXTENSIIONS)
            } else {
                scxmlBolero.terminateScanDir(scxmlBolero.driveCD)
            }
        }
    }

    Playlist {
        id: playlistSD

        property bool enabled: scxmlBolero.driveSourceSD_On

        onEnabledChanged: {
            this.clear()

            if (enabled) {
                scxmlBolero.scanDirAsync(scxmlBolero.driveSD, Consts.t_MEDIA_AVAILABLE_EXTENSIIONS)
            } else {
                scxmlBolero.terminateScanDir(scxmlBolero.driveSD)
            }
        }
    }

    Playlist {
        id: playlistUSB

        property bool enabled: scxmlBolero.driveSourceUSB_On

        onEnabledChanged: {
            this.clear()

            if (enabled) {
                scxmlBolero.scanDirAsync(scxmlBolero.driveUSB, Consts.t_MEDIA_AVAILABLE_EXTENSIIONS)
            } else {
                scxmlBolero.terminateScanDir(scxmlBolero.driveUSB)
            }
        }
    }

    FolderListModel {
        id: audioFolders

        nameFilters: Consts.t_MEDIA_AVAILABLE_EXTENSIIONS

        folder: ""
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Inp.App.Media.Btn.Selection"]
        onOccurred: {

            var s_folder_url = scxmlBolero.settings.MediaFolder

            if (!scxmlBolero.urlDirExists(s_folder_url)) {
                if (scxmlBolero.audioSourceCD) {
                    s_folder_url = scxmlBolero.driveCD
                } else if (scxmlBolero.audioSourceSD) {
                    s_folder_url = scxmlBolero.driveSD
                } else if (scxmlBolero.audioSourceUSB) {
                    s_folder_url = scxmlBolero.driveUSB
                }
            }

            scxmlBolero.submitEvent("Inp.App.BtnSetup.DirSelected", s_folder_url)
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.CheckDriveSources"]

        property bool presentDriveCD: false
        property bool presentDriveSD: false
        property bool presentDriveUSB: false

        onOccurred: {

            var bCD = scxmlBolero.urlDirExists(scxmlBolero.driveCD)
            var bSD = scxmlBolero.urlDirExists(scxmlBolero.driveSD)
            var bUSB = scxmlBolero.urlDirExists(scxmlBolero.driveUSB)

            if (bCD!==presentDriveCD) {
                presentDriveCD = bCD
                scxmlBolero.submitEvent("Inp.App.DriveSource.CD", bCD ? 1 : 0)
            }
            if (bSD!==presentDriveSD) {
                presentDriveSD = bSD
                scxmlBolero.submitEvent("Inp.App.DriveSource.SD", bSD ? 1 : 0)
            }
            if (bUSB!==presentDriveUSB) {
                presentDriveUSB = bUSB
                scxmlBolero.submitEvent("Inp.App.DriveSource.USB", bUSB ? 1 : 0)
            }

            /* finalizing event */
            scxmlBolero.submitEvent("Inp.App.DriveCheckCompleted")
        }
    }
}



