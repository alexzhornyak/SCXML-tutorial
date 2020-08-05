import QtQuick 2.0
import "AppConstants.js" as AppConsts

Item {
    id: header
    property alias caption: textCaption.text

    Text {
        id: textCaption
        anchors.left: header.left
        anchors.leftMargin: AppConsts.i_SETTINGS_BUTTON_OFFSET
        anchors.verticalCenter: header.verticalCenter
        verticalAlignment: Text.AlignVCenter
        style: Text.Outline
        color: AppConsts.cl_ITEM_TEXT
        font.family: "Tahoma"
        font.pixelSize: 26
    }

    SelectBackButton {
        id: btnBack
        anchors.right: header.right
        anchors.top: header.top
        anchors.bottom: header.bottom
    }
}
