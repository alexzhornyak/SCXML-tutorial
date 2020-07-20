import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../BoleroConstants.js" as Consts

Pane {
    id: paneRadio
    width: 600
    height: 360
    opacity: 1
    padding: 0
    clip: true

    readonly property int i_ROW_SPACING: 3

    property alias swipeStations: swipeStations
    property alias radioMouseArea: radioMouseArea

    property alias currentTimeText: textTime.text
    property alias currentTemperatureText: textTemperature.text

    background: BoleroBackground {
        anchors.fill: parent
    }

    MouseArea {
        id: radioMouseArea
        hoverEnabled: true
        anchors.fill: parent

        Item {
            id: contentPaddingItem
            anchors.fill: parent
            anchors.margins: Consts.i_DISPLAY_PADDING

            RadioBottomPanel {
                id: bottomPanel
                height: parent.height / 6
                visible: true
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }

            PageIndicator {
                id: pageIndicator
                count: 3
                height: paneRadio.height / 6
                font.family: "Tahoma"
                padding: 0
                leftPadding: width / 6
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: bottomPanel.top
                currentIndex: swipeStations.currentIndex

                delegate: Rectangle {
                    y: parent.height / 2
                    implicitWidth: swipeStations.width / 5
                    implicitHeight: parent.height / 10

                    border.width: 2
                    border.color: pageIndicator.currentIndex
                                  === index ? Consts.cl_SELECTION : Consts.cl_BACKGROUND_LIGHT

                    color: Consts.cl_BACKGROUND_LIGHT

                    MouseArea {
                        anchors.fill: parent
                        anchors.topMargin: -20
                        anchors.bottomMargin: -20
                        onClicked: swipeStations.currentIndex = index
                    }
                }
            }

            SwipeStations {
                id: swipeStations
                clip: true
                height: parent.height / 3
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: pageIndicator.top
            }

            Item {
                id: headerPanel
                height: 36
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top

                Text {
                    id: textTime
                    text: "00:00"
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: "Tahoma"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 16
                    style: Text.Outline
                    color: Consts.cl_ITEM_TEXT
                }

                Text {
                    id: textTemperature
                    text: "15 °C"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    font.family: "Tahoma"
                    font.pixelSize: 16
                    style: Text.Outline
                    color: Consts.cl_ITEM_TEXT
                }
            }

            RadioTop2Panel {
                id: rowTopSelect
                anchors.top: headerPanel.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: paneRadio.height / 6
            }
        }

        RadioManualTuning {
            id: manualTuning
            visible: scxmlBolero.radioTuneFreqOn
            height: parent.height / 6 + Consts.i_DISPLAY_PADDING
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }
}
