import QtQuick 2.12
import QtQuick.Controls 2.12
import "../"
import "AppConstants.js" as AppConsts

BoleroBackgroundRender {
    id: background

    property string caption: ""
    property alias contentData: content.data

    readonly property real headerHeight: height/6 - AppConsts.i_DISPLAY_PADDING

    Item {
        id: layerItem
        anchors.fill: parent
        anchors.margins: AppConsts.i_DISPLAY_PADDING

        Item {
            id: header

            height: background.headerHeight

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            Text {
                id: textCaption
                text: caption
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

        Item {
            id: content

            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.topMargin: AppConsts.i_SETTINGS_GRID_SPACING
        }
    }


}



