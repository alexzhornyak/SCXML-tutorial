import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "qrc:/Qml"
import "qrc:/Qml/AppConstants.js" as AppConsts

FrameRadioForm {
    id: frameRadio

    radioMouseArea.onHoveredChanged: scxmlBolero.submitEvent("Inp.App.Radio.Hovered", radioMouseArea.containsMouse ? 1:0)

    radioModalOverlayMouseArea.onClicked: scxmlBolero.submitEvent("Inp.App.Radio.ModalOverlay.Clicked")
}
