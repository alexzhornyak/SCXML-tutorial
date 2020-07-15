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
    padding: 8
    clip: true

    readonly property int i_ROW_SPACING: 3

    property alias viewStations: viewStations
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

        RadioBottomButtons {
            id: rowButtons
            height: parent.height / 6
            spacing: 3
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
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: rowButtons.top
            currentIndex: viewStations.currentIndex

            delegate: Rectangle {
                id: delegateItemPageIndicator
                y: parent.height / 2
                implicitWidth: viewStations.width / 5
                implicitHeight: parent.height / 10

                border.width: 2
                border.color: pageIndicator.currentIndex
                              === index ? Consts.cl_SELECTION : Consts.cl_BACKGROUND_LIGHT

                color: Consts.cl_BACKGROUND_LIGHT

                MouseArea {
                    anchors.fill: parent
                    anchors.topMargin: -20
                    anchors.bottomMargin: -20
                    onClicked: viewStations.currentIndex = index
                }
            }
        }

        SwipeView {
            id: viewStations
            clip: true
            padding: 0
            currentIndex: 0
            height: parent.height / 3
            visible: true
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: pageIndicator.top
            hoverEnabled: true

            Repeater {
                id: stations
                model: 3

                delegate: RowLayout {
                    id: stationsRow
                    spacing: 5

                    readonly property int groupIndex: index

                    Repeater {
                        id: repeater
                        model: 5

                        delegate: RadioStation {
                            stationIndex: (stationsRow.groupIndex * 5) + index
                        }
                    }
                }
            }
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
                font.family: "Tahoma"
                anchors.verticalCenter: parent.verticalCenter
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

        RadioSelectAndInfoRow {
            id: rowTopSelect
            anchors.top: headerPanel.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: paneRadio.height / 6
        }
    }
}

/*##^##
Designer {
    D{i:14;anchors_y:12}D{i:12;anchors_width:200;anchors_x:97;anchors_y:8}
}
##^##*/

