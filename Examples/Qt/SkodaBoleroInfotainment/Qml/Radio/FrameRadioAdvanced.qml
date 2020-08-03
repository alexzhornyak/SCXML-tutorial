import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts
import "../../Model/CommonConstants.js" as Consts

FrameSettings {

    caption: qsTr("Advanced setup")

    viewLayout.columns: 1

    showModal: scxmlBolero.radioAdvancedSetupModal
    showDialog: scxmlBolero.radioAdvancedSetupConfirmation

    repeater.model: [
        {
            text: "Alternative frequency (AF)",
            eventName: "Radio.AF",
            eventData: { checkName: "RadioAF", isConfirmation: 1 },
            showCheckBox: true,
            isChecked: scxmlBolero.settings.RadioAF === true,
            enabled: scxmlBolero.settings.RadioRDS === true,
            confirmationText: "Deactivate alternative\n" +
                              "frequency - are you sure?\n" +
                              "Reception quality may\n" +
                              "be reduced."
        },
        {
            text: "Radio Data System (RDS)",
            eventName: "Radio.RDS",
            eventData: { checkName: "RadioRDS", isConfirmation: 1 },
            showCheckBox: true,
            isChecked: scxmlBolero.settings.RadioRDS === true,
            confirmationText: "Deactivate RDS - are you sure?\n" +
                              "Without FM RDS, additional info\n" +
                              "cannot be received and station\n" +
                              "tracking will not be possible via\n" +
                              "alternative frequencies."
        },
        {
            text: "RDS Regional",
            eventName: "Radio.RegionalRDS",
            eventData: { isModal: 1 },
            valueText: scxmlBolero.settings.RegionalRDS,
            enabled: scxmlBolero.settings.RadioRDS === true,
            menu: [
                { row: 0, text: Consts.t_RADIO_REGIONAL_RDS[0],
                    eventData: { setName: "RegionalRDS", setValue: Consts.t_RADIO_REGIONAL_RDS[0] },
                    showRadioBtn: true,
                    isChecked: scxmlBolero.settings.RegionalRDS === Consts.t_RADIO_REGIONAL_RDS[0],
                    textKeyCentered: false },
                { row: 1, text: Consts.t_RADIO_REGIONAL_RDS[1],
                    showRadioBtn: true,
                    eventData: { setName: "RegionalRDS", setValue: Consts.t_RADIO_REGIONAL_RDS[1] },
                    isChecked: scxmlBolero.settings.RegionalRDS === Consts.t_RADIO_REGIONAL_RDS[1],
                    textKeyCentered: false }
            ]
        },
        {
            text: "Auto-save station logos",
            eventName: "Radio.AutoSaveLogos",
            eventData: { checkName: "RadioAutoSaveLogos" },
            enabled: scxmlBolero.settings.RadioRDS === true,
            showCheckBox: true,
            isChecked: scxmlBolero.settings.RadioAutoSaveLogos === true
        }
    ]

}



