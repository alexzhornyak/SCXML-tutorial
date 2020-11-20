import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQml.Models 2.12
import QtScxml 5.8
import "qrc:/Qml"
import "qrc:/Qml/AppConstants.js" as AppConsts
import "qrc:/Model/CommonConstants.js" as Consts

FrameSettings {
    id: frame
    caption: qsTr(scxmlBolero.settings.BandType + " setup")

    showModal: scxmlBolero.radioSetupMainModal
    encoderHighliterEnabled: scxmlBolero.radioSetupMain

    viewLayout.columns: 2

    repeater.model: [
        { text: "Sound", eventName: "Radio.Sound" }, { text: "Scan", eventName: "Radio.Scan" },

        { text: "Arrow buttons", eventName: "Radio.Arrows", eventData: { isModal: 1 },
            colSpan: 2, valueText: scxmlBolero.settings.RadioArrows,
            valueTextMargin: AppConsts.i_SETTINGS_BUTTON_OFFSET + viewLayout.columnSpacing/2,
            menu: [
                { row: 0, text: Consts.t_RADIO_ARROWS[0],
                    eventData: { setName: "RadioArrows", setValue: Consts.t_RADIO_ARROWS[0] },
                    showRadioBtn: true,
                    isChecked: scxmlBolero.settings.RadioArrows === Consts.t_RADIO_ARROWS[0],
                    keyCentered: false },
                { row: 1, text: Consts.t_RADIO_ARROWS[1],
                    eventData: { setName: "RadioArrows", setValue: Consts.t_RADIO_ARROWS[1] },
                    showRadioBtn: true,
                    isChecked: scxmlBolero.settings.RadioArrows === Consts.t_RADIO_ARROWS[1],
                    keyCentered: false }
            ]
        },

        { text: "Traffic programme (TP)", eventName: "Radio.Traffic", eventData: { checkName: "RadioTraffic" },
            colSpan: 2, showCheckBox: true, isChecked: scxmlBolero.settings.RadioTraffic === true,
            enabled: scxmlBolero.settings.RadioRDS === true
        },

        { text: "Delete presets", eventName: "Radio.DeletePresets" }, { text: "Station logos", eventName: "Radio.StationLogos"},

        { text: "Radio text", eventName: "Radio.Text", eventData: { checkName: "RadioText" }, showCheckBox: true, isChecked: scxmlBolero.settings.RadioText === true,
            visible: scxmlBolero.settings.BandType === "FM",
            enabled: scxmlBolero.settings.RadioRDS === true
        },
        { text: "Advanced setup", eventName: "Radio.Advanced",
            visible: scxmlBolero.settings.BandType === "FM" }
    ]
}



