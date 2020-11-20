import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtScxml 5.8
import "qrc:/Qml"
import "qrc:/Qml/AppConstants.js" as AppConsts

BoleroBackgroundRender {
    id: frame

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

            caption: qsTr("Bass - Mid - Treble")

            SimpleSelectButton {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: header.anchorBackLeft
                anchors.rightMargin: 4
                width: 140

                caption: qsTr("Reset")
            }
        }

        RowLayout {
            anchors.top: header.bottom
            anchors.topMargin: 8

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            spacing: 8

            Repeater {
                model: ["Bass", "Mid", "Treble"]

                Equalizer {
                    equalizerCaption: qsTr(modelData)

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }
        }


    }
}



