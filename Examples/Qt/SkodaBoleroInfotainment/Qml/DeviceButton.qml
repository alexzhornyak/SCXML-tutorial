import QtQuick 2.7
import MaskedMouseArea 1.0
import "AppConstants.js" as AppConsts

Image {

    scale: btnMouseArea.pressed ? AppConsts.d_BTN_SCALE : 1.0
    opacity: btnMouseArea.containsMouse ? AppConsts.d_BTN_OPACITY : 1.0

    property string name: ""
    source: "Images/Btn" + name + ".png"
    readonly property string eventName: "Inp.Btn." + name

    MaskedMouseArea {
        id: btnMouseArea
        anchors.fill: parent
        alphaThreshold: 0.4
        maskSource: parent.source

        onPressedChanged: scxmlBolero.submitEvent(eventName, pressed ? 1 : 0)
    }
}
