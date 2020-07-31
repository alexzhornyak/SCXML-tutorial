import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtScxml 5.8
import "../"
import "AppConstants.js" as AppConsts

BoleroBackgroundRender {
    id: frame

    property string caption: ""
    property alias repeater: repeaterSettings

    property real modalY0: 0
    property real modalY1: 0
    property real modalRightMargin: AppConsts.i_DISPLAY_PADDING + AppConsts.i_SETTINGS_BUTTON_OFFSET
    property alias showModal: modalLayout.visible
    property alias showDialog: confirmDialog.visible

    readonly property real headerHeight: height/6 - AppConsts.i_DISPLAY_PADDING
    property alias viewLayout: viewLayout

    property QtObject selectedObject: null

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

            visible: !frame.showDialog

            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.topMargin: AppConsts.i_SETTINGS_GRID_SPACING

            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.vertical.interactive: false

            EncoderHighlighter {
                id: highlighter
                rotateEnabled: !frame.showModal && !frame.showDialog
                selectEnabled: !frame.showDialog
                count: repeaterSettings.count
                eventName: selectedIndex!==-1 ? repeaterSettings.model[selectedIndex].eventName : ""
                eventData: selectedIndex!==-1 ? repeaterSettings.model[selectedIndex].eventData : ""
            }

            GridLayout {
                id: viewLayout
                columnSpacing: AppConsts.i_SETTINGS_GRID_SPACING
                rowSpacing: AppConsts.i_SETTINGS_GRID_SPACING

                width: view.availableWidth - AppConsts.i_SETTINGS_BUTTON_OFFSET

                Repeater {
                    id: repeaterSettings

                    delegate: SetupButton {
                        id: button
                        itemSelected: index === highlighter.selectedIndex || pressed
                        onItemSelectedChanged: {
                            if (itemSelected) {

                                frame.selectedObject = button

                                var coordinates = button.mapToItem(frame, 0, 0)

                                frame.modalY0 = coordinates.y
                                frame.modalY1 = coordinates.y + button.height

                                if (modelData.confirmationText) {
                                    dialogTextElement.text = modelData.confirmationText
                                }

                                if (modelData.menu) {
                                    balloonLoader.sourceComponent = balloonComponent
                                }
                            }
                        }

                        Component {
                            id: balloonComponent
                            BalloonPopup {
                                id: balloon
                                balloonDirection: BalloonCanvas.BalloonDirection.Left
                                model: modelData.menu
                            }
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

            anchors.top: parent.top
            anchors.bottom:  parent.bottom
            anchors.left: rectLeft.right
            anchors.right: rectRight.left

            anchors.topMargin: frame.modalY1

            MouseArea {
                id: modalLayer2
                anchors.fill: parent
                onClicked: scxmlBolero.submitEvent("Inp.App.Setup.ModalClick")
            }
        }

        Loader {
            id: balloonLoader

            x: viewLayout.width / 2
            y: modalY0
            width: viewLayout.width / 2// + offsetX
        }
    }    

    Rectangle {
        id: confirmDialog

        color: AppConsts.cl_BACKGROUND_OPACITY

        visible: false
        anchors.fill: parent

        MouseArea {

            anchors.fill: parent

            Rectangle {
                id: dialog

                color: AppConsts.cl_BACKGROUND
                border.color: AppConsts.cl_ITEM_BORDER
                border.width: 3
                radius: 3

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                anchors.leftMargin: AppConsts.i_DISPLAY_PADDING
                anchors.rightMargin: AppConsts.i_DISPLAY_PADDING
                anchors.bottomMargin: AppConsts.i_DISPLAY_PADDING

                height: dialogContentLayout.height

                EncoderHighlighter {
                    id: highlighterDialog
                    rotateEnabled: frame.showDialog
                    selectEnabled: frame.showDialog
                    count: repeaterDialog.count
                    eventName: selectedIndex!==-1 ? repeaterDialog.model[selectedIndex].eventName : ""
                    eventData: selectedIndex!==-1 ? repeaterDialog.model[selectedIndex].eventData : ""
                }

                ColumnLayout {
                    id: dialogContentLayout

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom

                    anchors.margins: dialog.border.width * 2

                    Text {
                        id: dialogTextElement
                        verticalAlignment: Text.AlignVCenter
                        style: Text.Outline
                        color: AppConsts.cl_ITEM_TEXT
                        font.family: "Tahoma"
                        font.pixelSize: 24
                        lineHeight: 1.5

                        Layout.leftMargin: 20
                        Layout.topMargin: 10
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }


                    RowLayout {

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Repeater {
                            id: repeaterDialog
                            model: [
                                { text: "Cancel", eventName: "Modal.Result", eventData: 0, textKeyCentered: true },
                                { text: "Deactivate", eventName: "Modal.Result", eventData: 1, textKeyCentered: true }
                            ]

                            delegate: SetupButton {
                                itemSelected: index === highlighterDialog.selectedIndex
                            }
                        }
                    }
                }

            }
        }


    }
}



