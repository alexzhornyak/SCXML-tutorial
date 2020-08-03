import QtQuick 2.12
import QtQuick.Layouts 1.12
import "AppConstants.js" as AppConsts

Rectangle {
    id: confirmDialog

    color: AppConsts.cl_BACKGROUND_OPACITY

    property string eventName: "Modal.Result"
    property alias dialogText: dialogTextElement.text

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

            anchors.centerIn: parent

            width: parent.width - AppConsts.i_DISPLAY_PADDING*2
            height: dialogContentLayout.height

            EncoderHighlighter {
                id: highlighterDialog
                count: repeaterDialog.count
                eventName: confirmDialog.eventName
                eventData: selectedIndex!==-1 ? repeaterDialog.model[selectedIndex].eventData : undefined
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
                            { text: "Cancel", eventData: 0, textKeyCentered: true },
                            { text: "Deactivate", eventData: 1, textKeyCentered: true }
                        ]

                        delegate: SetupButton {
                            eventName: confirmDialog.eventName
                            eventData: modelData.eventData
                            itemSelected: index === highlighterDialog.selectedIndex
                        }
                    }
                }
            }

        }
    }


}
