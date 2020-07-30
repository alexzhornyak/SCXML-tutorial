import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import ScxmlBolero 1.0
import "../"
import "../AppConstants.js" as AppConsts

FocusButtonForm {
    id: focusBtn

    Layout.fillWidth: true
    Layout.fillHeight: true

    Behavior on verticalFooterOffset {
        NumberAnimation { duration: 250 }
    }

    Behavior on verticalImageOffset {
        NumberAnimation { duration: 250 }
    }

    selectButton.onClicked: {
        if (focusBtn.name === "Band") {
            var coordinates = focusBtn.mapToItem(radioPopupBandsLoader.parent, 0, -radioPopupBandsLoader.height)
            radioPopupBandsLoader.popupX = coordinates.x + focusBtn.width/2;
            radioPopupBandsLoader.popupY = coordinates.y;
        }
        scxmlBolero.submitEvent("Inp.App.Radio.Btn." + focusBtn.name)
    }
}
