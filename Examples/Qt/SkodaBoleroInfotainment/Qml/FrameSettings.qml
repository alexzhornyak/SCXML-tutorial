import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtScxml 5.8
import "../"
import "AppConstants.js" as AppConsts
import "../Model/CommonConstants.js" as Consts

BoleroBackgroundRender {
    id: frame

    property string caption: ""
    property alias repeater: repeater

    property real modalY0: 0
    property real modalY1: 0
    property real modalRightMargin: AppConsts.i_DISPLAY_PADDING + AppConsts.i_SETTINGS_BUTTON_OFFSET
    property alias showModal: modalLayout.visible

    readonly property real headerHeight: height/6 - AppConsts.i_DISPLAY_PADDING
    property alias viewLayout: viewLayout

    property int selectedIndex: -1

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Inp.Rotate.Select"]
        onOccurred: {
            var dDelta = parseFloat(event.data)

            frame.selectedIndex = Consts.incrementMinMaxWrap(frame.selectedIndex,
                                                                dDelta>0 ? 1 : (dDelta<0 ? -1 : 0),
                                                                0, repeater.count)
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Inp.Enc.Select"]
        onOccurred: {
//            if (frame.selectedIndex!==-1)
//                scxmlBolero.submitBtnSetupEvent(model[repeater.selectedIndex].eventName, model[repeater.selectedIndex].eventData)
        }
    }


    Item {
        id: layerItem
        anchors.fill: parent
        anchors.margins: AppConsts.i_DISPLAY_PADDING

        Item {
            id: header

            height: frame.headerHeight

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

        ScrollView {
            id: view

            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.topMargin: AppConsts.i_SETTINGS_GRID_SPACING

            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.vertical.interactive: false

            GridLayout {
                id: viewLayout
                columnSpacing: AppConsts.i_SETTINGS_GRID_SPACING
                rowSpacing: AppConsts.i_SETTINGS_GRID_SPACING

                width: view.availableWidth - AppConsts.i_SETTINGS_BUTTON_OFFSET

                Repeater {
                    id: repeater

                    delegate: SetupButton {
                        id: button
                        itemSelected: index === frame.selectedIndex

                        onPressed: {
                            var coordinates = viewLayout.mapToItem(frame, 0, button.y)
                            frame.modalY0 = coordinates.y
                            frame.modalY1 = coordinates.y + button.height + viewLayout.columnSpacing
                        }
                    }
                }
            }
        }
    }

    /* DropDown element is highlighted and out area is modal */
    Item {
        id: modalLayout
        anchors.fill: parent
        visible: false

        Rectangle {
            id: rectLeft
            color: AppConsts.cl_BACKGROUND
            opacity: AppConsts.d_MODAL_OPACITY

            anchors.top:  parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom

            width: AppConsts.i_DISPLAY_PADDING
        }

        Rectangle {
            id: rectRight
            color: AppConsts.cl_BACKGROUND
            opacity: AppConsts.d_MODAL_OPACITY

            anchors.top:  parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            width: frame.modalRightMargin
        }

        Rectangle {
            id: rectLayer1
            color: AppConsts.cl_BACKGROUND
            opacity: AppConsts.d_MODAL_OPACITY

            anchors.top:  parent.top
            anchors.left: rectLeft.right
            anchors.right: rectRight.left

            height: frame.modalY0

            MouseArea {
                id: modalLayer1
                anchors.fill: parent
                onClicked: scxmlBolero.submitEvent("Inp.App.Setup.ModalClick")
            }
        }

        Rectangle {
            id: rectLayer2
            color: AppConsts.cl_BACKGROUND
            opacity: AppConsts.d_MODAL_OPACITY

            anchors.bottom:  parent.bottom
            anchors.left: rectLeft.right
            anchors.right: rectRight.left

            height: frame.modalY1

            MouseArea {
                id: modalLayer2
                anchors.fill: parent
                onClicked: scxmlBolero.submitEvent("Inp.App.Setup.ModalClick")
            }
        }
    }

}



