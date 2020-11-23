import QtQuick 2.0
import QtScxml 5.8
import "qrc:/Model/CommonConstants.js" as Consts

Item {
    id: encoder

    property int selectedIndex: -1
    required property int count
    required property string eventName
    required property variant eventData

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Inp.Rotate.Select"]
        onOccurred: {
            if (encoder.enabled) {
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
            if (encoder.enabled) {
                // encoder pressed
                if (event.data===1) {
                    scxmlBolero.submitBtnSetupEvent(encoder.eventName, encoder.eventData)
                }
            }
        }
    }
}
