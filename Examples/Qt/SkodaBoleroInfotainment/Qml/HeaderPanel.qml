import QtQuick 2.0
import "AppConstants.js" as AppConsts

Item {
    id: headerPanel
    implicitHeight: 36

    readonly property date currentTime: new Date()

    Text {
        id: textTime
        text: currentTime.toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Tahoma"
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 16
        style: Text.Outline
        color: AppConsts.cl_ITEM_TEXT
    }

    Image {
        id: imgMute
        visible: scxmlBolero.muteOn
        anchors.right: textTime.left
        anchors.verticalCenter: parent.verticalCenter
        source: "Images/ImgMute.png"
        fillMode: Image.Pad
    }

    Text {
        id: textTemperature
        text: "15 °C"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        font.family: "Tahoma"
        font.pixelSize: 16
        style: Text.Outline
        color: AppConsts.cl_ITEM_TEXT
    }
}
