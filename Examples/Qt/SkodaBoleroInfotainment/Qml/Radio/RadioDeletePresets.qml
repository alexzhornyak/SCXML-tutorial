import QtQuick 2.0
import "../AppConstants.js" as AppConsts
import "../"

BoleroBackgroundRender {
    id: frame

    readonly property real headerHeight: height/6 - AppConsts.i_DISPLAY_PADDING


    Item {
        id: layerItem
        anchors.fill: parent
        anchors.margins: AppConsts.i_DISPLAY_PADDING

        SetupHeader {
            id: header

            height: frame.headerHeight

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            caption: frame.caption
        }
    }
}
