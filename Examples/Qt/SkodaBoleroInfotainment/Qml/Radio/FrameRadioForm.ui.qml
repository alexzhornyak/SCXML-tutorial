import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Extras 1.4
import "../"
import "../BoleroConstants.js" as Consts

Pane {
    id: paneRadio
    width: 600
    height: 360
    opacity: 1
    padding: 8
    clip: true
    anchors.fill: parent

    readonly property int i_ROW_SPACING: 3

    property alias viewStations: viewStations
    property alias radioMouseArea: radioMouseArea

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
            visible: true
            spacing: i_ROW_SPACING
            anchors.right: parent.right
            anchors.left: parent.left
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
                y: parent.height / 2
                implicitWidth: viewStations.width / 5
                implicitHeight: parent.height / 10

                border.width: 2
                border.color: pageIndicator.currentIndex
                              === index ? Consts.cl_SELECTION : Consts.cl_BACKGROUND_LIGHT

                color: Consts.cl_BACKGROUND_LIGHT
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

                delegate: Row {
                    id: stationsRow
                    spacing: paneRadio.i_ROW_SPACING

                    readonly property int groupIndex: index

                    Repeater {
                        id: repeater
                        model: 5

                        delegate: StationRectangle {
                            stationIndex: (stationsRow.groupIndex * 5) + index
                            width: viewStations.width / repeater.model
                                   - (paneRadio.i_ROW_SPACING
                                      - (paneRadio.i_ROW_SPACING / repeater.model))
                            height: width

                            color: stationsRow.groupIndex
                                   === 0 ? "yellow" : stationsRow.groupIndex === 1 ? "red" : "blue"
                        }
                    }
                }
            }
        }
    }
}
