import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "qrc:/Qml"

Item {
    id: panel

    RowLayout {
        id: rowButtons

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        width: 300

        spacing: 3

        Repeater {
            id: repeaterButtons

            model: [
                { eventName: "MediaFunc.Reverse", enabled: true, keyCentered: true,
                    imageKeySource: "qrc:/Qml/Images/ImgRewindBack_48.png" },
                { eventName: "MediaFunc.Play", enabled: true, keyCentered: true,
                    imageKeySource: scxmlBolero.mediaPlaying ? "qrc:/Qml/Images/ImgPause_48.png" : "qrc:/Qml/Images/ImgPlay_48.png" },
                { eventName: "MediaFunc.Forward", enabled: true, keyCentered: true,
                    imageKeySource: "qrc:/Qml/Images/ImgRewindForward_48.png"}
            ]

            delegate: SetupButton {                
                topBorderVisible: scxmlBolero.mediaAccentOn

                onPressed: scxmlBolero.submitBtnSetupEvent(eventName, 1)
                onReleased: scxmlBolero.submitBtnSetupEvent(eventName, 0)
            }
        }
    }

    MediaRepeatButton {
        id: repeatBtn
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        implicitWidth: 65
    }

    MediaScanButton {
        visible: scxmlBolero.mediaPlayerScanModeOn

        anchors.left: repeatBtn.right
        anchors.leftMargin: 3
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        implicitWidth: 65
    }

    MediaShuffleButton {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        implicitWidth: 65
    }

}
