import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "qrc:/Qml"
import "qrc:/Qml/AppConstants.js" as AppConsts

BoleroBackgroundRender {
    id: frame
    clip: true

    readonly property real headerHeight: height/6 - AppConsts.i_DISPLAY_PADDING

    Item {
        id: layerItem
        anchors.fill: parent
        anchors.margins: AppConsts.i_DISPLAY_PADDING

        SetupHeader {
            id: header

            height: frame.headerHeight

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            caption: qsTr("Balance - Fader")
        }

        Text {
            id: tempText
            anchors.centerIn: parent
            color: "white"
            text: "Balance-Fader in progress..."
            font.family: "Tahoma"
            font.pixelSize: 26
        }

    }

}
