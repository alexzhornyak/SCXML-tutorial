import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts

FrameRadioForm {
    id: frameRadio

    property date currentTime: new Date()
    currentTimeText: currentTime.toLocaleTimeString(Qt.locale(), Locale.ShortFormat)

    radioMouseArea {
        id: radioMouseArea
        onHoveredChanged: {
            scxmlBolero.submitEvent("Inp.App.Radio.Hovered", radioMouseArea.containsMouse ? 1:0)
        }

        onClicked: {
            scxmlBolero.submitEvent("Inp.App.Radio.Clicked")
        }        
    }

    /* we use this special overlay to prevent affect on whole application */
    Rectangle {
        id: radioModalOverlay
        color: "#80000000"
        anchors.fill: parent
        visible: scxmlBolero.radioModal

        MouseArea {
            id: radioModalOverlayMouseArea
            anchors.fill: parent

            onClicked: {
                scxmlBolero.submitEvent("Inp.App.Radio.ModalOverlay.Clicked")
            }
        }
    }

    function setSelectedSwipeIndex(active) {
        if (active) {
            var i_selected = scxmlBolero.settings.Bands[scxmlBolero.settings.BandType].Selected
            swipeStations.currentIndex =  Math.floor(i_selected/ 5)
        }
    }

    Component.onCompleted: {
        scxmlBolero.onRadioInputChanged.connect(setSelectedSwipeIndex)
    }
}
