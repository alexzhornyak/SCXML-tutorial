import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts
import "../../Model/CommonConstants.js" as Consts

FrameSettings {
    id: frame
    caption: qsTr(scxmlBolero.settings.BandType + " station list")

    encoderHighliterEnabled: scxmlBolero.radioStationsList

    viewLayout.columns: 1

    repeater.model: getStationListModel()

    function getStationListModel() {
        var t_MODEL = []

        var bandType = scxmlBolero.settings.BandType
        var currentBand = scxmlBolero.settings.Bands[bandType]
        if (currentBand && currentBand.Stations) {
            for (var i=0;i<currentBand.Stations.length;i++) {
                var item = {                    
                    text: scxmlBolero.getRadioDisplayFreq(currentBand.Stations[i].Freq) +
                        " " +
                        qsTr(scxmlBolero.bandTypeFM ? "MHz" : "kHz"),
                    eventName: "Inp.App.Radio.SetFreq",
                    eventData: currentBand.Stations[i].Freq
                }
                t_MODEL.push(item)
            }
        }

        return t_MODEL
    }
}
