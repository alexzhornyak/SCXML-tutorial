import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtScxml 5.8
import ScxmlBolero 1.0
import QtMultimedia 5.12
import Qt.labs.folderlistmodel 2.15
import FileUtils 1.0
import "qrc:/Qml"
import "qrc:/Qml/AppConstants.js" as AppConsts
import "qrc:/Model/CommonConstants.js" as Consts

FrameSelectFilesBase {
    id: frame

    folderNameFilters: Consts.t_MEDIA_AVAILABLE_EXTENSIONS
    folderSortField: FolderListModel.Type
    enabled: scxmlBolero.mediaTrackList
    visible: enabled

    folderUrl: audioPlayer.currentPlayUrlPath
    currentUrl: audioPlayer.currentPlayUrl

    function getItemIcon(url, is_current_item) {
        if (is_current_item) {
            switch (audioPlayer.currentAudio.playbackState) {
            case Audio.PlayingState:
                return "qrc:/Qml/Images/ImgPlaylistPause_32.png"
            case Audio.PausedState:
            case Audio.StoppedState:
                return "qrc:/Qml/Images/ImgPlaylistPlay_32.png"
            }
        }
        return ""
    }

    itemHeight: 50
    itemIconWidth: 32
    itemIconFillMode: Image.Pad

    functionsPanel.height: itemHeight
    functionsPanel.anchors.topMargin: AppConsts.i_SETTINGS_GRID_SPACING
    functionsPanel.data: [
        RowLayout {

            anchors.fill: parent            

            SelectButton {
                Layout.preferredWidth: parent.width / 4
                topBorderVisible: true

                onReleased: scxmlBolero.submitBtnSetupEvent("MediaFunc.Play")

                Image {
                    anchors.centerIn: parent
                    fillMode: Image.Pad
                    source: scxmlBolero.mediaPlaying ? "qrc:/Qml/Images/ImgPause_48.png" : "qrc:/Qml/Images/ImgPlay_48.png"
                }
            }

            MediaShuffleButton {
                topBorderVisible: true
                Layout.preferredWidth: parent.width / 4
            }

            MediaRepeatButton {
                topBorderVisible: true
                Layout.preferredWidth: parent.width / 4
            }

            MediaScanButton {
                Layout.preferredWidth: parent.width / 4
                topBorderVisible: true
            }
        }
    ]
}
