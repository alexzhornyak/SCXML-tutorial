import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtScxml 5.8
import "AppConstants.js" as AppConsts

BoleroBackgroundRender {
    id: frame

    property string caption: ""
    property alias repeater: repeaterSettings

    property real modalY0: 0
    property real modalY1: 0
    property real modalRightMargin: AppConsts.i_DISPLAY_PADDING + AppConsts.i_SETTINGS_BUTTON_OFFSET
    property bool showModal: false
    property bool showDialog: false

    readonly property real headerHeight: height/6 - AppConsts.i_DISPLAY_PADDING
    property alias viewLayout: viewLayout

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
                enabled: !frame.showModal && !frame.showDialog
                count: repeaterSettings.count
                eventName: selectedIndex!==-1 ? repeaterSettings.model[selectedIndex].eventName : ""
                eventData: selectedIndex!==-1 ? repeaterSettings.model[selectedIndex].eventData : undefined
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
                        onPressed: {
                            highlighter.selectedIndex = -1
                        }
                        onItemSelectedChanged: {
                            if (itemSelected) {

                                /* prepare data for dynamically loaded components */

                                var coordinates = button.mapToItem(frame, 0, 0)

                                frame.modalY0 = coordinates.y
                                frame.modalY1 = coordinates.y + button.height

                                if (modelData.confirmationText) {
                                    confirmDialogLoader.text = modelData.confirmationText
                                }

                                if (modelData.menu) {
                                    balloonLoader.model = modelData.menu
                                    balloonLoader.eventName = modelData.eventName
                                }
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
        visible: frame.showModal

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
    }    

    Loader {
        id: balloonLoader

        parent: frame
        y: modalY0 - 6 /* top to accent rectangle: 4-spacing, 2-line width */
        anchors.left: parent.left
        anchors.leftMargin: viewLayout.width/2 - AppConsts.i_SETTINGS_GRID_SPACING/2
        anchors.right: parent.right
        anchors.rightMargin: AppConsts.i_DISPLAY_PADDING + AppConsts.i_SETTINGS_BUTTON_OFFSET - AppConsts.i_SETTINGS_GRID_SPACING/2

        property variant model: null
        property string eventName: ""

        sourceComponent: frame.showModal ? balloonComponent : undefined

        Component {
            id: balloonComponent

            BalloonPopup {
                balloonDirection: BalloonCanvas.BalloonDirection.Left
                model: balloonLoader.model
                eventName: balloonLoader.eventName
            }
        }
    }

    Loader {
        id: confirmDialogLoader

        anchors.fill: parent

        sourceComponent: frame.showDialog ? confirmDialogComponent : undefined
        property string text: ""

        Component {
            id: confirmDialogComponent
            ConfirmDialog {
                id: confirmDialog
                anchors.fill: parent
                dialogText: confirmDialogLoader.text
            }
        }
    }
}



