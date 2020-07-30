import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQml.Models 2.12
import QtScxml 5.8
import "../"
import "../AppConstants.js" as AppConsts

FrameSettings {
    id: frame
    caption: qsTr(scxmlBolero.settings.BandType + " setup")

    showModal: scxmlBolero.radioSettingsMainModal

    viewLayout.columns: 2

    repeater.model: [
        { text: "Sound", eventName: "Radio.Sound" }, { text: "Scan", eventName: "Radio.Scan" },
        { text: "Arrow buttons", eventName: "Radio.Arrows", colSpan: 2, valueText: scxmlBolero.settings.RadioArrows,
            valueTextMargin: AppConsts.i_SETTINGS_BUTTON_OFFSET + viewLayout.columnSpacing/2 },
        { text: "Traffic programme (TP)", eventName: "Radio.Traffic", colSpan: 2,
            isChecked: scxmlBolero.settings.RadioTraffic === true },
        { text: "Delete presets", eventName: "Radio.DeletePresets" }, { text: "Station logos", eventName: "Radio.StationLogos"},
        { text: "Radio text", eventName: "Radio.Text", isChecked: scxmlBolero.settings.RadioText === true,
            visible: scxmlBolero.settings.BandType === "FM"},
        { text: "Advanced setup", eventName: "Radio.Advanced",
            visible: scxmlBolero.settings.BandType === "FM" }
    ]
}



