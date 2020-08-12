import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts

BoleroBackgroundRender {
    id: paneRadio
    width: 600
    height: 360
    clip: true

    readonly property int i_ROW_SPACING: 3

    property alias swipeStations: swipeStations
    property alias radioMouseArea: radioMouseArea
    property alias radioModalOverlayMouseArea: radioModalOverlayMouseArea

    property alias currentTimeText: textTime.text
    property alias currentTemperatureText: textTemperature.text

    MouseArea {
        id: radioMouseArea
        hoverEnabled: true
        anchors.fill: parent

        Item {
            id: contentPaddingItem
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: bottomPanel.top
            anchors.leftMargin: AppConsts.i_DISPLAY_PADDING
            anchors.topMargin: AppConsts.i_DISPLAY_PADDING
            anchors.rightMargin: AppConsts.i_DISPLAY_PADDING

            PageIndicator {
                id: pageIndicator
                count: 3
                height: paneRadio.height / 6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                currentIndex: swipeStations.currentIndex

                delegate: Rectangle {
                    y: parent.height / 2
                    implicitWidth: contentPaddingItem.width / 5
                    implicitHeight: 6

                    border.width: 2
                    border.color: pageIndicator.currentIndex
                                  === index ? AppConsts.cl_SELECTION : AppConsts.cl_BACKGROUND_LIGHT

                    color: AppConsts.cl_BACKGROUND_LIGHT

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
                height: paneRadio.height / 3 - AppConsts.i_DISPLAY_PADDING
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
                    color: AppConsts.cl_ITEM_TEXT
                }

                Image {
                    id: imgMute
                    visible: scxmlBolero.muteOn
                    anchors.right: textTime.left
                    anchors.verticalCenter: parent.verticalCenter
                    source: "../Images/ImgMute.png"
                    fillMode: Image.Pad
                }

                Text {
                    id: textTemperature
                    text: "15 °C"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    font.family: "Tahoma"
                    font.pixelSize: 16
                    style: Text.Outline
                    color: AppConsts.cl_ITEM_TEXT
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

        /* we use this special overlay to prevent affect on whole application */
        Rectangle {
            id: radioModalOverlay
            color: AppConsts.cl_BACKGROUND
            opacity: AppConsts.d_MODAL_OPACITY
            anchors.fill: parent

            visible: scxmlBolero.radioModal

            MouseArea {
                id: radioModalOverlayMouseArea
                anchors.fill: parent
            }
        }

        RadioBottomPanel {
            id: bottomPanel
            height: paneRadio.height / 6 - AppConsts.i_DISPLAY_PADDING
            visible: true
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: AppConsts.i_DISPLAY_PADDING
            anchors.leftMargin: AppConsts.i_DISPLAY_PADDING
            anchors.rightMargin: AppConsts.i_DISPLAY_PADDING
        }

        RadioManualTuning {
            id: manualTuning
            visible: scxmlBolero.radioTuneFreqOn
            height: paneRadio.height / 6 + AppConsts.i_DISPLAY_PADDING
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }
}
