import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import ScxmlBolero 1.0

FocusButtonForm {

    Behavior on verticalFooterOffset {
        NumberAnimation { duration: 500 }
    }

    Behavior on verticalImageOffset {
        NumberAnimation { duration: 500 }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            //scxmlBolero.submitEvent("Inp.App.Radio." + name)
            popup.open()
        }
    }

    Popup {
            id: popup
//            x: parent.left
//            y: parent.bottom + 200
//            width: 200
//            height: 300
            //modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

            ColumnLayout {
                    anchors.fill: parent
                    CheckBox { text: qsTr("FM") }
                    CheckBox { text: qsTr("AM") }
            }
   }
}
