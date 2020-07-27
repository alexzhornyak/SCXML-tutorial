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

    Component.onCompleted: {
        if (name === "Band") {
            scxmlBolero.onRadioPopupBandsChanged.connect(openPopupBands)
        }
    }

    function openPopupBands(active) {
        if (active) {
            popupRadioBands.x = focusBtn.x + focusBtn.width / 2 - (canvasRadioBands.triangleOffsetX + canvasRadioBands.triangleEdge)
            popupRadioBands.y = focusBtn.y - popupRadioBands.height            
            popupRadioBands.open()
        } else {
            popupRadioBands.close()
        }
    }

    selectButton.onClicked: scxmlBolero.submitEvent("Inp.App.Radio.Btn." + name)    

    Popup {
        id: popupRadioBands
        x: 0
        y: 0
        width: focusBtn.width * 1.5
        height: 126
        focus: true
        closePolicy: Popup.NoAutoClose
        modal: false
        topPadding: 6
        leftPadding: 6
        rightPadding: 6
        bottomPadding: 14

        ColumnLayout {
            id: columnLayout
            anchors.fill: parent

            Repeater {

                model: [
                    { name: "FM" },
                    { name: "AM" }
                ]

                delegate: SelectButton {
                    Text {
                        anchors.fill: parent
                        text: qsTr(modelData.name)
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        style: Text.Outline
                        color: AppConsts.cl_ITEM_TEXT
                        font.family: "Tahoma"
                        font.pixelSize: 20
                    }
                    onClicked: scxmlBolero.submitEvent("Inp.App.Radio.BandType", modelData.name)
                }
            }
        }

        background: BalloonCanvas {
            id: canvasRadioBands
            anchors.fill: parent
            strokeStyle: AppConsts.cl_ITEM_BORDER
            fillStyle: AppConsts.cl_BACKGROUND
        }
   }
}
