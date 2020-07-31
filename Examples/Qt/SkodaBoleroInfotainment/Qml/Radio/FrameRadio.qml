import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts

FrameRadioForm {
    id: frameRadio

    property date currentTime: new Date()
    currentTimeText: currentTime.toLocaleTimeString(Qt.locale(), Locale.ShortFormat)

    radioMouseArea.onHoveredChanged: scxmlBolero.submitEvent("Inp.App.Radio.Hovered", radioMouseArea.containsMouse ? 1:0)

    radioModalOverlayMouseArea.onClicked: scxmlBolero.submitEvent("Inp.App.Radio.ModalOverlay.Clicked")
}
