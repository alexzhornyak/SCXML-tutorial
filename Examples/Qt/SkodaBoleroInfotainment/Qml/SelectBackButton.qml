import QtQuick 2.0

SelectButton {

    implicitWidth: 90

    onClicked: scxmlBolero.submitEvent("Inp.App.Btn.Back")

    Image {
        id: imgArrowBack

        anchors.centerIn: parent
        fillMode: Image.Pad
        source: "Images/ImgArrowBack.png"
    }
}
