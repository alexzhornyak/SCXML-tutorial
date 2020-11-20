import QtQuick 2.0
import "qrc:/Qml"

SelectButton {
    topBorderVisible: scxmlBolero.mediaAccentOn

    onReleased: scxmlBolero.submitBtnSetupEvent("MediaFunc.Repeat")

    Image {
        anchors.centerIn: parent
        fillMode: Image.Pad
        source: scxmlBolero.mediaRepeatTrack ? "qrc:/Qml/Images/ImgMediaTrackRepeat_48.png" :
                scxmlBolero.mediaRepeatFolder ? "qrc:/Qml/Images/ImgMediaFolderRepeat_48.png" :
                                                "qrc:/Qml/Images/ImgMediaNoRepeat_48.png"
    }
}
