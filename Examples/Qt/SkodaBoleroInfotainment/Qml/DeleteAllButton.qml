import QtQuick 2.0
import "AppConstants.js" as AppConsts

SelectButton {
    id: button
    implicitWidth: 200

    required property string confirmationText
    onClicked: scxmlBolero.submitEvent("Inp.App.Btn.DeleteAll", {
                                           confirmationText: button.confirmationText,
                                           confirmationModel: [
                                               { text: "Cancel", textKeyCentered: true },
                                               { text: "Delete", eventData: 1, textKeyCentered: true }]
                                       })

    Image {
        id: img
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.Pad
        source: "Images/ImgDelete.png"
    }

    Text {
        id: textCaption
        anchors.leftMargin: 10
        anchors.left: img.right
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        style: Text.Outline
        color: AppConsts.cl_ITEM_TEXT
        font.family: "Tahoma"
        font.pixelSize: 20

        text: qsTr("Delete all")
    }
}
