import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import ScxmlBolero 1.0
import "AppConstants.js" as AppConsts

SelectButton {
    id: focusBtn

    property alias footerText: footer.text

    property string imgSource: ""
    property string btnCaption: ""

    /* user */
    property real verticalImageOffset: topBorderVisible ? -footer.height / 2 : 0
    property real verticalFooterOffset: topBorderVisible ? 0 + 3 : -height + 3

    Layout.fillWidth: true
    Layout.fillHeight: true

    Behavior on verticalFooterOffset {
        NumberAnimation { duration: 250 }
    }

    Behavior on verticalImageOffset {
        NumberAnimation { duration: 250 }
    }

    Loader {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: verticalImageOffset

        sourceComponent: focusBtn.imgSource === "" ? textComponent : imgComponent
    }

    Component {
        id: imgComponent

        Image {
            id: image

            source: focusBtn.imgSource

            fillMode: Image.Pad

            width: 48
            height: 48
        }
    }

    Component {
        id: textComponent

        Text {
            id: bandText
            text: focusBtn.btnCaption
            color: AppConsts.cl_ITEM_TEXT
            style: Text.Outline
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Tahoma"
            font.pixelSize: 20
        }
    }

    Text {
        id: footer
        color: AppConsts.cl_ITEM_TEXT
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottomMargin: verticalFooterOffset
        style: Text.Outline
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "Tahoma"
        font.pixelSize: 14
    }
}

