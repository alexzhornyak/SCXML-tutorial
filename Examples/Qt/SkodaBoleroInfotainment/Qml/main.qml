import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ScxmlBolero 1.0
import QtScxml 5.8

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1397
    height: 743
    color: "#1d1d1d"
    title: qsTr("Infotainment Radio Bolero (Simulator)")

    onClosing: {
        scxmlBolero.submitEvent("Inp.Quit")
    }

    ScxmlBolero {
        id: scxmlBolero
        running: true

        onModeRadioChanged: {
            if (active) {
                mainWidget.container.push("FrameRadio.ui.qml")
            } else {
                mainWidget.container.clear()
            }
        }
    }

    MainWidget {
        id: mainWidget
        anchors.centerIn: parent
    }
}
