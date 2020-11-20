import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtScxml 5.8
import "AppConstants.js" as AppConsts
import "qrc:/Model/CommonConstants.js" as Consts


BalloonCanvas {
    id: balloon
    implicitHeight: layout.height + layout.columnSpacing * 2
    strokeStyle: AppConsts.cl_ITEM_BORDER
    fillStyle: AppConsts.cl_BACKGROUND

    property alias model: repeater.model
    property alias eventName: highlighter.eventName
    readonly property int selectedIndex: highlighter.selectedIndex

    EncoderHighlighter {
        id: highlighter
        count: repeater.model.length
        eventData: selectedIndex!==-1 ? repeater.model[selectedIndex].eventData : undefined
    }

    contentData: [
        GridLayout {
            id: layout
            anchors.left: parent.left
            anchors.right: parent.right

            Repeater {
                id: repeater

                delegate: SetupButton {

                    itemSelected: index === highlighter.selectedIndex

                    eventName: highlighter.eventName
                    eventData: modelData.eventData

                    Layout.column: modelData.col === undefined ? 0 : modelData.col
                    Layout.row: modelData.row === undefined ? 0 : modelData.row
                    Layout.columnSpan: modelData.colSpan === undefined ? 1 : modelData.colSpan
                    Layout.rowSpan: modelData.rowSpan === undefined ? 1 : modelData.rowSpan
                }
            }
        }
    ]
}

