import QtQuick 2.0
import "AppConstants.js" as AppConsts

SelectButton {

    property alias caption: textCaption.text

    contentItem: Text {
        id: textCaption
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        style: Text.Outline
        color: AppConsts.cl_ITEM_TEXT
        font.family: "Tahoma"
        font.pixelSize: 20
    }
}
