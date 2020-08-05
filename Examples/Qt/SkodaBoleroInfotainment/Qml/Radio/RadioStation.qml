import QtQuick 2.12

RadioStationBase {
    id: station

    onPressed: {
        scxmlBolero.submitEvent("Inp.App.Radio.StationPressed", stationIndex)
    }

    onReleased: {
        scxmlBolero.submitEvent("Inp.App.Radio.StationReleased", stationIndex)
    }

    onCanceled: {
        scxmlBolero.submitEvent("Inp.App.Radio.StationSwipe", stationIndex)
    }

    itemSelected: (scxmlBolero.getSelectedStation() === stationIndex) &&
                  (scxmlBolero.getRadioFreq(station.stationIndex) === scxmlBolero.getCurrentRadioFreq())
}
