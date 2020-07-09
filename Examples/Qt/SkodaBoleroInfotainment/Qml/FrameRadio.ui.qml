import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Extras 1.4

Pane {
    id: pane
    width: 594
    height: 355
    clip: true

    SwipeView {
        id: view
        currentIndex: 1
        anchors.fill: parent

        Row {
            spacing: 3

            Repeater {
                id: repeater
                model: 5

                Rectangle {
                    width: 115
                    height: 115

                    color: "yellow"
                }

            }
        }

        Row {
            spacing: 3

            Repeater {
                id: repeater2
                model: 5

                Rectangle {
                    width: 115
                    height: 115

                    color: "red"
                }

            }
        }

        Row {
            spacing: 3

            Repeater {
                id: repeater3
                model: 5

                Rectangle {
                    width: 115
                    height: 115

                    color: "blue"
                }

            }
        }

    }

    PageIndicator {
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
