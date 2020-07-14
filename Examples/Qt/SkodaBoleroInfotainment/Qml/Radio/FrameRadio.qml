import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../"
import "../BoleroConstants.js" as Consts

FrameRadioForm {

    radioMouseArea {
        id: radioMouseArea
        onHoveredChanged: {
            scxmlBolero.submitEvent("Inp.App.Radio.Hovered", radioMouseArea.containsMouse ? 1:0)
        }

        onClicked: {
            scxmlBolero.submitEvent("Inp.App.Radio.Clicked")
        }
    }

    opacity: scxmlBolero.radioModal ? 0.5 : 1.0
}
