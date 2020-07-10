import QtQuick 2.8
import ScxmlBolero 1.0

Item {

    width: 160
    height: 60

    /* alias */
    property alias imageSource: image.source
    property alias imageVisible: image.visible
    property alias text: footer.text
    property alias footer: footer

    /* user */
    property real verticalImageOffset: scxmlBolero.radioCaptionsOn ? -footer.height / 2 : 0
    property real verticalFooterOffset: scxmlBolero.radioCaptionsOn ? 0 : -height

    Rectangle {

        anchors.fill: parent

        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            color: "#bfffffff"

            height: 3
        }

        color: "#19ffffff"
        radius: 3
        border.width: 1
        border.color: "#bfffffff"
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
        color: "#ffffff"
        anchors.centerIn: parent
        visible: !image.visible
        text: "FM"
        anchors.verticalCenterOffset: verticalImageOffset
        style: Text.Outline
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "Tahoma"
        font.pixelSize: 20
    }

    Text {
        id: footer
        color: "#ffffff"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottomMargin: verticalFooterOffset
        text: "ModelData"
        style: Text.Outline
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "Tahoma"
        font.pixelSize: 14
    }
}
