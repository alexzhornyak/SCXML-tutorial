import QtQuick 2.0
import QtQuick.Controls 2.2

FrameRadioForm {

    radioMouseArea {
        id: radioMouseArea
        onHoveredChanged: {
            scxmlBolero.submitEvent("Inp.App.Radio.Captions", radioMouseArea.containsMouse ? 1:0)
        }
    }
}
