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

    property string currentPlayUrl: audio.playlist !== null ? audio.playlist.currentItemSource : ""
    property alias currentPlayPos: audio.position
    property alias currentPlayDuration: audio.duration

    property alias currentAudio: audio

    Connections {
        target: fileUtils

        function onMediaScanCompleted(sUrl, outList) {

            var playlist = undefined
            var source = undefined

            if (sUrl===storageCD.urlPath) {
                playlist = playlistCD
                source = "CD"
            } else if (sUrl===storageSD.urlPath) {
                playlist = playlistSD
                source = "SD"
            } else if (sUrl===storageUSB.urlPath) {
                playlist = playlistUSB
                source = "USB"
            } else {
                console.error("Undefined media url:", sUrl)
            }

            if (playlist) {
                playlist.clear()
                for (var file of outList) {
                    playlist.addItem(fileUtils.urlFromLocalFile(file))
                }

                scxmlBolero.submitEvent("Inp.App.Media.DriveScanned." + source);
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.MediaSource.*"]
        onOccurred: {
            var audioSource = event.name.replace("Out.MediaSource.", "")

            var t_Playlists = {
                CD: playlistCD,
                SD: playlistSD,
                USB: playlistUSB
            }

            var playlist = t_Playlists[audioSource]

            if (playlist) {
                audio.playlist = playlist

                var savedIndex = undefined

                if (event.data) {
                    for (var i=0;i<playlist.itemCount;i++) {
                        var sUrlSource = playlist.itemSource(i)
                        var sUrlEvent = event.data

                        if (sUrlSource.toString().toLowerCase() === sUrlEvent.toString().toLowerCase()) {
                            savedIndex = i
                            break;
                        }
                    }
                }

                if (savedIndex) {
                    audio.playlist.currentIndex = savedIndex
                }


                scxmlBolero.submitEvent("Inp.App.Media.Reload")

                if (scxmlBolero.muteOn) {
                    audio.pause()
                } else {
                    audio.play()
                }

                if (scxmlBolero.settings.Drives && scxmlBolero.settings.Drives[audioSource]) {
                    var seekPos = scxmlBolero.settings.Drives[audioSource].MediaPosition

                    if (seekPos!==undefined) {
                        audio.seek(seekPos)
                    }
                }
            } else {
                audio.playlist = null
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.Play"]
        onOccurred: {
            audio.play()
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.Pause"]
        onOccurred: {
            audio.pause()
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.Track.Next"]
        onOccurred: {
            if (audio.playlist!=null && audio.playlist.itemCount &&
                    audio.playlist.currentIndex < audio.playlist.itemCount - 1) {

                audio.playlist.currentIndex++
                scxmlBolero.submitEvent("Inp.App.Media.State", audio.playbackState)
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.Track.Previous"]
        onOccurred: {
            if (audio.playlist!=null && audio.playlist.itemCount &&
                    audio.playlist.currentIndex > 0) {

                audio.playlist.currentIndex--
                scxmlBolero.submitEvent("Inp.App.Media.State", audio.playbackState)
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.Track.Beginning"]
        onOccurred: {
            if (audio.playlist!=null && audio.playlist.itemCount) {

                audio.seek(0)
                scxmlBolero.submitEvent("Inp.App.Media.State", audio.playbackState)
            }
        }
    }

    Audio {
        id: audio

        muted: scxmlBolero.muteOn
        volume: scxmlBolero.getVolume()

        onPlaybackStateChanged: scxmlBolero.submitEvent("Inp.App.Media.State", audio.playbackState)
        onPositionChanged: {
            scxmlBolero.submitEvent("Inp.App.Media.Position", audio.position)
        }
    }

    Playlist {
        id: playlistCD

        property bool enabled: scxmlBolero.driveSourceCD_On

        onEnabledChanged: {
            this.clear()

            if (enabled) {
                fileUtils.scanDirAsync(storageCD.urlPath, Consts.t_MEDIA_AVAILABLE_EXTENSIONS)
            } else {
                fileUtils.terminateScanDir(storageCD.urlPath)
            }
        }

        onCurrentItemSourceChanged: scxmlBolero.submitEvent("Inp.App.Media.Source.CD", currentItemSource)
    }

    Playlist {
        id: playlistSD

        property bool enabled: scxmlBolero.driveSourceSD_On

        onEnabledChanged: {
            this.clear()

            if (enabled) {
                fileUtils.scanDirAsync(storageSD.urlPath, Consts.t_MEDIA_AVAILABLE_EXTENSIONS)
            } else {
                fileUtils.terminateScanDir(storageSD.urlPath)
            }
        }

        onCurrentItemSourceChanged: scxmlBolero.submitEvent("Inp.App.Media.Source.SD", currentItemSource)
    }

    Playlist {
        id: playlistUSB

        property bool enabled: scxmlBolero.driveSourceUSB_On

        onEnabledChanged: {
            this.clear()

            if (enabled) {
                fileUtils.scanDirAsync(storageUSB.urlPath, Consts.t_MEDIA_AVAILABLE_EXTENSIONS)
            } else {
                fileUtils.terminateScanDir(storageUSB.urlPath)
            }
        }

        onCurrentItemSourceChanged: scxmlBolero.submitEvent("Inp.App.Media.Source.USB", currentItemSource)

    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Inp.App.Media.Btn.Selection"]
        onOccurred: {

            var s_folder_url = fileUtils.urlExtractPath(currentPlayUrl)

            if (!fileUtils.urlExists(s_folder_url)) {
                if (scxmlBolero.audioSourceCD) {
                    s_folder_url = storageCD.urlPath
                } else if (scxmlBolero.audioSourceSD) {
                    s_folder_url = storageSD.urlPath
                } else if (scxmlBolero.audioSourceUSB) {
                    s_folder_url = storageUSB.urlPath
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

            var bCD = storageSD.enabled
            var bSD = storageSD.enabled
            var bUSB = storageSD.enabled

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



