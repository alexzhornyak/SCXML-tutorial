import QtQuick 2.8
import ScxmlBolero 1.0
import "../"
import "../BoleroConstants.js" as Consts

Item {

    width: 160
    height: 60

    /* alias */
    property alias imageSource: image.source
    property alias imageVisible: image.visible
    property alias text: footer.text
    property alias footer: footer
    property alias selectButton: selectButton

    /* user */    
    property real verticalImageOffset: scxmlBolero.radioAccentOn ? -footer.height / 2 : 0
    property real verticalFooterOffset: scxmlBolero.radioAccentOn ? 0 + 3 : -height + 3
    property string name: ""

    SelectButton {
        id: selectButton
        anchors.fill: parent
        topBorderVisible: scxmlBolero.radioAccentOn
    }

    Image {
        id: image
        anchors.centerIn: parent
        anchors.verticalCenterOffset: verticalImageOffset
        width: 48
        height: 48
    }

    Text {
        id: bandText
        color: Consts.cl_ITEM_TEXT
        anchors.centerIn: parent
        visible: !image.visible
        text: scxmlBolero.bandTypeFM ? "FM" : "AM" /* untranslatable */
        anchors.verticalCenterOffset: verticalImageOffset
        style: Text.Outline
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "Tahoma"
        font.pixelSize: 20
    }

    Text {
        id: footer
        color: Consts.cl_ITEM_TEXT
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottomMargin: verticalFooterOffset
        text: "Undefined"
        style: Text.Outline
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "Tahoma"
        font.pixelSize: 14
    }
}
