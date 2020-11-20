import QtQuick 2.0
import "qrc:/Qml"

SelectButton {
    topBorderVisible: scxmlBolero.mediaAccentOn

    onReleased: scxmlBolero.submitBtnSetupEvent("MediaFunc.Shuffle")

    Image {
        anchors.centerIn: parent
        fillMode: Image.Pad
        source: scxmlBolero.mediaPlayMixModeOn ? "qrc:/Qml/Images/ImgShuffleOn_48.png" :
                                                 "qrc:/Qml/Images/ImgShuffleOff_48.png"
    }
}
