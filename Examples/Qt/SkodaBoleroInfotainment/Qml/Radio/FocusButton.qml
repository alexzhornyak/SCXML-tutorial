import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import ScxmlBolero 1.0
import "../"
import "../BoleroConstants.js" as Consts

FocusButtonForm {
    id: focusBtn

    Behavior on verticalFooterOffset {
        NumberAnimation { duration: 500 }
    }

    Behavior on verticalImageOffset {
        NumberAnimation { duration: 500 }
    }

    Component.onCompleted: {
        if (name === "Band") {
            scxmlBolero.onRadioPopupBandsChanged.connect(openPopupBands)
        }
    }

    function openPopupBands(active) {
        if (active) {
            popupRadioBands.x = focusBtn.x + focusBtn.width / 2 - (canvasRadioBands.triangleOffsetX + canvasRadioBands.triangleEdge)
            popupRadioBands.y = focusBtn.y - popupRadioBands.height
            popupRadioBands.parent = focusBtn
            popupRadioBands.open()
        } else {
            popupRadioBands.close()
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            scxmlBolero.submitEvent("Inp.App.Radio.Btn." + name)
        }
    }
}
