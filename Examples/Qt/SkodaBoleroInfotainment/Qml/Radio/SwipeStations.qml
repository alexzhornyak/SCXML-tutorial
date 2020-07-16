import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

SwipeView {
    id: _swipeStations
    clip: true
    padding: 0
    currentIndex: 0
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
