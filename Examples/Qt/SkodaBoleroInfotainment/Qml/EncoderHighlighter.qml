import QtQuick 2.0
import QtScxml 5.8
import "../Model/CommonConstants.js" as Consts

Item {
    id: encoder

    property int selectedIndex: -1
    required property int count
    required property string eventName
    required property variant eventData

    required property bool rotateEnabled
    required property bool selectEnabled

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Inp.Rotate.Select"]
        onOccurred: {
            if (rotateEnabled) {
                var dDelta = parseFloat(event.data)

                encoder.selectedIndex =
                        Consts.incrementMinMaxWrap(
                            encoder.selectedIndex,
                            dDelta>0 ? 1 : (dDelta<0 ? -1 : 0), 0, encoder.count)
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Inp.Enc.Select"]
        onOccurred: {
            if (selectEnabled) {
                if (event.data) {
                    if (encoder.selectedIndex!==-1)
                        scxmlBolero.submitBtnSetupEvent(encoder.eventName, encoder.eventData)
                }
            }
        }
    }
}
