import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtScxml 5.8
import "AppConstants.js" as AppConsts
import "../Model/CommonConstants.js" as Consts


BalloonCanvas {
    id: balloon
    implicitHeight: layout.height + layout.columnSpacing * 2
    strokeStyle: AppConsts.cl_ITEM_BORDER
    fillStyle: AppConsts.cl_BACKGROUND

    property alias model: repeater.model

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Inp.Rotate.Select"]
        onOccurred: {
            var dDelta = parseFloat(event.data)

            repeater.selectedIndex = Consts.incrementMinMaxWrap(repeater.selectedIndex,
                                                                dDelta>0 ? 1 : (dDelta<0 ? -1 : 0),
                                                                0, model.length)
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Inp.Enc.Select"]
        onOccurred: {
            if (repeater.selectedIndex!=-1)
                scxmlBolero.submitBtnSetupEvent(model[repeater.selectedIndex].eventName, model[repeater.selectedIndex].eventData)
        }
    }

    contentData: [
        GridLayout {
            id: layout
            anchors.left: parent.left
            anchors.right: parent.right

            Repeater {
                id: repeater

                property int selectedIndex: -1

                delegate: SetupButton {

                    itemSelected: index === repeater.selectedIndex

                    Layout.column: modelData.col === undefined ? 0 : modelData.col
                    Layout.row: modelData.row === undefined ? 0 : modelData.row
                    Layout.columnSpan: modelData.colSpan === undefined ? 1 : modelData.colSpan
                    Layout.rowSpan: modelData.rowSpan === undefined ? 1 : modelData.rowSpan
                }
            }
        }
    ]
}

