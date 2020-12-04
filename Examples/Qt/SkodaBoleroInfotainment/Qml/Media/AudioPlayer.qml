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

        function onMediaScanCompleted(url, outList) {

            var audio_input = undefined

            for (var storage of storageList) {
                if (url.toString().toLowerCase()===storage.urlPath.toString().toLowerCase()) {
                    audio_input = storage.ident
                    break
                }
            }

            if (audio.playlists[audio_input]) {
                audio.playlists[audio_input].All = outList.slice()
                audio.playlists[audio_input].RepeatFolder.length = 0

                if (scxmlBolero["audioInput" + audio_input + "_Ready"]) {
                    if (scxmlBolero.mediaRepeatFolder) {
                        audio.updateRepeatFolderList()
                    }
                }

                scxmlBolero.submitEvent("Inp.App.Media.DriveScanned." + audio_input);
            } else {
                console.error("Can not complete drive:", url, audio_input)
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.Media.Source.*"]
        onOccurred: {
            var url = scxmlBolero.getCurrentMediaUrl()
            var list = audio.getAbsolutePlaylist()

            if (!list || list.length===0) {
                scxmlBolero.submitEvent("Inp.App.Media.Error")
                console.error("No valid media")
            }
            else {
                var index = audio.getSourceIndex(url, list)

                if (index===-1) {
                    scxmlBolero.submitEvent("Inp.App.Media.Source", list[0])
                } else {
                    scxmlBolero.submitEvent("Inp.App.Media.ValidSource", url)

                    audio.stop()
                    audio.source = url

                    if (event.name === "Out.Media.Source.Restore") {

                        if (scxmlBolero.mediaRepeatFolder) {
                            audio.updateRepeatFolderList()
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

                audio.playbackState===Audio.PlayingState ? audio.pause() : audio.play()

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
                audio.updateRepeatFolderList()
            }
        }
    }

    Audio {
        id: audio

        muted: scxmlBolero.muteOn || scxmlBolero.mediaRewindOn
        volume: QtMultimedia.convertVolume(scxmlBolero.getVolume(),
                                           QtMultimedia.LogarithmicVolumeScale,
                                           QtMultimedia.LinearVolumeScale)

        property var playlists: getPlaylistTables()

        function getPlaylistTables() {
            var t_playlists = {}

            for (var storage of storageList) {
                t_playlists[storage.ident] = {
                    'All': [], 'RepeatFolder':[]
                }
            }

            return t_playlists
        }

        function updateRepeatFolderList() {
            if (source=="")
                return

            var audio_input = scxmlBolero.settings.AudioInput
            var current_playlist = playlists[audio_input]
            if (current_playlist) {

                current_playlist.RepeatFolder.length = 0

                var repeat_url = fileUtils.urlExtractPath(source)

                var s_url_path = repeat_url.toString().toLowerCase()

                var b_disable_subfolders = scxmlBolero.settings.MediaDisableSubfolders

                for (var cur_url of current_playlist.All) {
                    var cur_url_adopted = cur_url.toString().toLowerCase()
                    var s_cur_url_path = cur_url_adopted.substring(0,cur_url_adopted.lastIndexOf('/'))

                    if (b_disable_subfolders) {
                        if (s_cur_url_path === s_url_path) {
                            current_playlist.RepeatFolder.push(cur_url)
                        }
                    } else {
                        if (s_cur_url_path.indexOf(s_url_path) === 0) {
                            current_playlist.RepeatFolder.push(cur_url)
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
                if (i_item_count>0) {
                    var index = getSourceIndex(url, cur_playlist)
                    if (index===-1) {
                        console.error("Increment> Url is not found in playlist", url)
                    } else {
                        if (scxmlBolero.mediaPlayMixModeOn) {
                            increment *= Consts.getRandomInt(1, i_item_count - 1)
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

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.DriveDetected.*"]

        /*
            we store the path because it may be changed through settings
            and we won't be able to terminate it correctly
        */
        property var pathList: []

        onOccurred: {
            var s_ident = event.name.replace("Out.DriveDetected.", "")

            var storage = storageList.find(elem => elem.ident === s_ident)
            if (storage) {
                if (event.data === 1) {                                        
                    pathList[s_ident] = storage.urlPath
                    fileUtils.scanDirAsync(pathList[s_ident], Consts.t_MEDIA_AVAILABLE_EXTENSIONS)
                } else {
                    fileUtils.terminateScanDir(pathList[s_ident])
                }
            } else {
                console.error("Drive ", s_ident, " is not found in the storage list!")
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.CheckDriveSources"]

        onOccurred: {

            for (var storage of storageList) {
                var s_ident = storage.ident

                storage.refresh()

                var b_enabled = storage.enabled
                var b_was_enabled = scxmlBolero["driveSource" + s_ident + "_On"]

                if (b_enabled!==b_was_enabled) {
                    scxmlBolero.submitEvent("Inp.App.DriveSource." + s_ident, b_enabled ? 1 : 0)                    
                }
            }

            /* finalizing event */
            scxmlBolero.submitEvent("Inp.App.DriveCheckCompleted")
        }
    }
}



