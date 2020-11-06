import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts

BoleroBackgroundRender {
    id: pane
    width: 600
    height: 360
    clip: true

    readonly property int i_ROW_SPACING: 3

//    property alias swipeStations: swipeStations
//    property alias radioMouseArea: radioMouseArea
//    property alias radioModalOverlayMouseArea: radioModalOverlayMouseArea

    MouseArea {
        id: paneMouseArea
        hoverEnabled: true
        anchors.fill: parent
        onHoveredChanged: scxmlBolero.submitEvent("Inp.App.Media.Hovered", paneMouseArea.containsMouse ? 1:0)

        Item {
            id: contentPaddingItem
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: bottomPanel.top
            anchors.leftMargin: AppConsts.i_DISPLAY_PADDING
            anchors.topMargin: AppConsts.i_DISPLAY_PADDING
            anchors.rightMargin: AppConsts.i_DISPLAY_PADDING

            HeaderPanel {
                id: headerPanel

                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
            }

        }

        /* we use this special overlay to prevent affect on whole application */
        Rectangle {

            color: AppConsts.cl_BACKGROUND
            opacity: AppConsts.d_MODAL_OPACITY
            anchors.fill: parent

            visible: scxmlBolero.mediaModal

            MouseArea {
                anchors.fill: parent

                onClicked: scxmlBolero.submitEvent("Inp.App.Media.ModalOverlay.Clicked")
            }
        }

        MediaBottomPanel {
            id: bottomPanel
            height: pane.height / 6 - AppConsts.i_DISPLAY_PADDING
            visible: true
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: AppConsts.i_DISPLAY_PADDING
            anchors.leftMargin: AppConsts.i_DISPLAY_PADDING
            anchors.rightMargin: AppConsts.i_DISPLAY_PADDING
        }
    }
}

