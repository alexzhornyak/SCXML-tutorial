import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

SwipeView {
    id: swipeStations
    clip: true
    padding: 0
    currentIndex:  0
    hoverEnabled: true

    Repeater {
        id: repeaterPresets
        model: 3

        delegate: RowLayout {
            id: stationsRow
            spacing: 5

            readonly property int groupIndex: index

            Repeater {
                id: repeaterStations
                model: 5

                delegate: RadioStation {
                    stationIndex: (stationsRow.groupIndex * 5) + index
                }
            }
        }
    }

    function setSelectedSwipeIndex(active) {
        if (active) {
            var iIndex = scxmlBolero.getSelectedStation()
            if (iIndex !== -1) {
                swipeStations.currentIndex = Math.floor(iIndex / 5)
            }
        }
    }

    Component.onCompleted: {
        scxmlBolero.onRadioInputChanged.connect(setSelectedSwipeIndex)
    }
}
