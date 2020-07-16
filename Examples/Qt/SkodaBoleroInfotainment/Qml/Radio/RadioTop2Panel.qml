import QtQuick 2.0
import "../"
import "../BoleroConstants.js" as Consts

Item {
    id: rowTopSelect

    Text {
        id: info
        text: scxmlBolero.getCaption(scxmlBolero.getCurrentRadioFreq(), "26", "20")
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        textFormat: Text.RichText
        color: Consts.cl_ITEM_TEXT
        style: Text.Outline
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        font.family: "Tahoma"
        font.pixelSize: 26
    }

    SelectDirectionButton {
        id: btnSelectLeft
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 80
        topBorderVisible: scxmlBolero.radioAccentOn
        isLeftDirection: true
    }

    SelectDirectionButton {
        id: btnSelectRight
        width: 80
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        topBorderVisible: scxmlBolero.radioAccentOn
        isLeftDirection: false
    }
}
