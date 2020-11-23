import QtQuick 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import Qt.labs.folderlistmodel 2.12
import ScxmlBolero 1.0
import QtScxml 5.8
import "qrc:/Qml"
import "qrc:/Model/CommonConstants.js" as Consts

Item {
    id: name

    readonly property url currentPlayUrl: audio.source
    readonly property url currentPlayUrlPath: fileUtils.urlExtractPath(audio.source)
    readonly property string currentPlayUrlFileName: fileUtils.urlExtractFileName(currentPlayUrl)
    property alias currentPlayPos: audio.position
    property alias currentPlayDuration: audio.duration

    property alias currentAudio: audio

    Connections {
        target: fileUtils

        function onMediaScanCompleted(sUrl, outList) {

            var audio_input = undefined

            if (sUrl===storageCD.urlPath) {                
                audio_input = "CD"
            } else if (sUrl===storageSD.urlPath) {                
                audio_input = "SD"
            } else if (sUrl===storageUSB.urlPath) {                
                audio_input = "USB"
            } else {
                console.error("Undefined media url:", sUrl)
            }

            if (audio.playlists[audio_input]) {
                outList.sort()

                audio.playlists[audio_input].All.length = 0
                audio.playlists[audio_input].RepeatFolder.length = 0

                for (var file of outList) {
                    audio.playlists[audio_input].All.push(fileUtils.urlFromLocalFile(file))
                }

                scxmlBolero.submitEvent("Inp.App.Media.DriveScanned." + audio_input);
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.Source.*"]
        onOccurred: {
            var url = scxmlBolero.getCurrentMediaUrl()
            var list = audio.getPlaylist()

            if (!list || list.length===0) {
                scxmlBolero.submitEvent("Inp.App.Media.Error")
                console.error("No valid media")
            }
            else {
                var index = audio.getSourceIndex(url, list)

                if (index===-1) {
                    scxmlBolero.submitEvent("Inp.App.Media.Source", list[0])
                } else {
                    scxmlBolero.submitEvent("Inp.App.Media.ValidSource")                    

                    audio.stop()
                    audio.source = url

                    if (event.name === "Out.Media.Source.Restore") {

                        if (scxmlBolero.mediaRepeatFolder) {
                            audio.updateRepeatFolderList(currentPlayUrlPath)
                        }

                        var media = scxmlBolero.getCurrentMedia()
                        if (media!==undefined) {
                            var seekPos = media.MediaPosition

                            if (seekPos!==undefined) {
                                audio.seek(seekPos)
                            }
                        }
                    }

                }
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.Track.Selected"]
        onOccurred: {
            if (event.data.toString().toLowerCase() === audio.source.toString().toLowerCase()) {
                /* inverse Play->Pause; Pause->Play */
                switch (audio.playbackState) {
                case Audio.PlayingState:
                    audio.pause()
                    break;
                case Audio.PausedState:
                    audio.play()
                    break
                }
            } else {
                var list = audio.getAbsolutePlaylist()
                if (list) {
                    var index = audio.getSourceIndex(event.data, list)
                    if (index!==-1) {
                        scxmlBolero.submitEvent("Inp.App.Media.Source", list[index])
                    } else {
                        console.error("Can't select track url", event.data)
                    }
                }
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
            audio.incrementSource(+1)
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.Track.Previous"]
        onOccurred: {
            audio.incrementSource(-1)
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.Track.Beginning"]
        onOccurred: {            
            audio.seek(0)
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.Rewind.Reverse"]
        onOccurred: {
            var i_step = parseInt(event.data)
            var i_pos = audio.position - i_step

            if (i_pos >= 0) {
                audio.seek(i_pos)
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.Rewind.Forward"]
        onOccurred: {
            var i_step = parseInt(event.data)
            var i_pos = audio.position + i_step

            if (i_pos < audio.duration) {
                audio.seek(i_pos)
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.RepeatFolder"]
        onOccurred: {
            if (scxmlBolero.mediaPlayerRun) {
                if (currentPlayUrlPath.toString()!=="") {
                    audio.updateRepeatFolderList(currentPlayUrlPath)
                }
            }
        }
    }

    Audio {
        id: audio

        muted: scxmlBolero.muteOn || scxmlBolero.mediaRewindOn
        volume: QtMultimedia.convertVolume(scxmlBolero.getVolume(),
                                           QtMultimedia.LogarithmicVolumeScale,
                                           QtMultimedia.LinearVolumeScale)

        property variant playlists: {
            'CD': { 'All': [], 'RepeatFolder':[] },
            'SD': { 'All': [], 'RepeatFolder':[] },
            'USB': { 'All': [], 'RepeatFolder':[] },
        }

        function updateRepeatFolderList(repeat_url) {
            var audio_input = scxmlBolero.settings.AudioInput
            if (playlists[audio_input]) {
                playlists[audio_input].RepeatFolder.length = 0
                var s_url_path = repeat_url.toString().toLowerCase()
                for (var cur_url of playlists[audio_input].All) {
                    var s_cur_url_path = fileUtils.urlExtractPath(cur_url).toString().toLowerCase()
                    if (scxmlBolero.settings.MediaDisableSubfolders) {
                        if (s_cur_url_path === s_url_path) {
                            playlists[audio_input].RepeatFolder.push(cur_url)
                        }
                    } else {
                        if (s_cur_url_path.indexOf(s_url_path) === 0) {
                            playlists[audio_input].RepeatFolder.push(cur_url)
                        }
                    }
                }
                scxmlBolero.submitEvent("Inp.App.Media.RepeatFolder", repeat_url)
            }
        }



        function getSourceIndex(url, list) {
            var s_url = url.toString().toLowerCase()
            if (s_url==="")
                return -1

            if (!list)
                return -1

            return list.findIndex(
                        item => item.toString().toLowerCase()===s_url
                        )
        }

        function getAbsolutePlaylist() {
            var audio_input = scxmlBolero.settings.AudioInput
            if (!playlists[audio_input])
                return undefined

            return playlists[audio_input].All
        }

        function getRepeatPlaylist() {
            var audio_input = scxmlBolero.settings.AudioInput
            if (!playlists[audio_input])
                return undefined

            return playlists[audio_input].RepeatFolder
        }

        function getPlaylist() {
            var audio_input = scxmlBolero.settings.AudioInput
            if (!playlists[audio_input])
                return undefined

            var is_repeated = scxmlBolero.mediaRepeatFolder

            var list = is_repeated ? playlists[audio_input].RepeatFolder :
                                     playlists[audio_input].All

            if (is_repeated && list.length===0) {
                list = playlists[audio_input].All
            }

            return list
        }

        function incrementSource(increment) {
            var url = scxmlBolero.getCurrentMediaUrl()

            var cur_playlist = getPlaylist()

            if (!cur_playlist) {                
                console.error("Increment> Can not retreive playlist", url)

                scxmlBolero.submitEvent("Inp.App.Media.Error")
            } else {
                var i_item_count = cur_playlist.length
                if (i_item_count>1) {
                    var index = getSourceIndex(url, cur_playlist)
                    if (index===-1) {
                        console.error("Increment> Url is not found in playlist", url)
                    } else {
                        if (scxmlBolero.mediaPlayMixModeOn) {
                            increment *= Consts.getRandomInt(i_item_count)
                        }

                        /*
                            remove element from lists to prevent recursive deadlock,
                            if all tracks are with faults
                        */
                        if (error !== Audio.NoError) {
                            console.error("Increment> Remove invalid url", url)
                            cur_playlist.splice(index,1)

                            /* check that error track is cleaned in other playlists */
                            var abs_list = getAbsolutePlaylist()
                            if (cur_playlist!==abs_list) {
                                var abs_index = getSourceIndex(abs_list)
                                if (abs_index!==-1) {
                                    abs_list.splice(abs_index, 1)
                                }
                            }
                        } else {
                            index = Consts.incrementMinMaxWrap(index, increment, 0, i_item_count)
                        }
                    }

                    if (cur_playlist.length === 0) {
                        console.warn("Increment> No more tracks in playlist!")
                        index = -1
                    }
                    else if (index >= cur_playlist.length) {
                        index = 0
                    }

                    if (index!==-1) {
                        scxmlBolero.submitEvent("Inp.App.Media.Source", cur_playlist[index])
                    }
                }
            }
        }

        onPlaybackStateChanged: {
            scxmlBolero.submitEvent("Inp.App.Media.State", playbackState)
        }
        onPositionChanged: {
            scxmlBolero.submitEvent("Inp.App.Media.Position", position)
        }
    }

    Connections {
        target: scxmlBolero

        property url pathCD: ""
        property url pathSD: ""
        property url pathUSB: ""

        function onDriveSourceCD_OnChanged(enter) {
            if (enter) {
                pathCD = storageCD.urlPath
                fileUtils.scanDirAsync(pathCD, Consts.t_MEDIA_AVAILABLE_EXTENSIONS)
            } else {
                fileUtils.terminateScanDir(pathCD)
            }
        }

        function onDriveSourceSD_OnChanged(enter) {
            if (enter) {
                pathSD = storageSD.urlPath
                fileUtils.scanDirAsync(pathSD, Consts.t_MEDIA_AVAILABLE_EXTENSIONS)
            } else {
                fileUtils.terminateScanDir(pathSD)
            }
        }

        function onDriveSourceUSB_OnChanged(enter) {
            if (enter) {
                pathUSB = storageUSB.urlPath
                fileUtils.scanDirAsync(pathUSB, Consts.t_MEDIA_AVAILABLE_EXTENSIONS)
            } else {
                fileUtils.terminateScanDir(pathUSB)
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.CheckDriveSources"]

        property bool presentDriveCD: false
        property bool presentDriveSD: false
        property bool presentDriveUSB: false

        onOccurred: {

            var bCD = storageCD.enabled
            var bSD = storageSD.enabled
            var bUSB = storageUSB.enabled

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



