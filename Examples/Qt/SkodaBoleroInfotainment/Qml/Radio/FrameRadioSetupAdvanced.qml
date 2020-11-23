import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "qrc:/Qml"
import "qrc:/Qml/AppConstants.js" as AppConsts
import "qrc:/Model/CommonConstants.js" as Consts

FrameSettings {

    caption: qsTr("Advanced setup")

    viewLayout.columns: 1

    showModal: scxmlBolero.radioAdvancedSetupModal
    showContent: !scxmlBolero.radioAdvancedSetupConfirmation
    encoderHighliterEnabled: scxmlBolero.radioAdvancedSetup

    repeater.model: [
        {
            text: "Alternative frequency (AF)",
            eventName: "Radio.AF",
            eventData: { checkName: "RadioAF", isConfirmation: 1,
                confirmationText: "Deactivate alternative\n" +
                                  "frequency - are you sure?\n" +
                                  "Reception quality may\n" +
                                  "be reduced.",
                confirmationModel: [
                    { text: "Cancel", keyCentered: true },
                    { text: "Deactivate", eventData: "RadioAF", keyCentered: true }]
            },
            showCheckBox: true,
            isChecked: scxmlBolero.settings.RadioAF === true,
            enabled: scxmlBolero.settings.RadioRDS === true
        },
        {
            text: "Radio Data System (RDS)",
            eventName: "Radio.RDS",
            eventData: { checkName: "RadioRDS", isConfirmation: 1,
                confirmationText: "Deactivate RDS - are you sure?\n" +
                                  "Without FM RDS, additional info\n" +
                                  "cannot be received and station\n" +
                                  "tracking will not be possible via\n" +
                                  "alternative frequencies.",
                confirmationModel: [
                    { text: "Cancel", keyCentered: true },
                    { text: "Deactivate", eventData: "RadioRDS", keyCentered: true }]
            },
            showCheckBox: true,
            isChecked: scxmlBolero.settings.RadioRDS === true
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
                    keyCentered: false },
                { row: 1, text: Consts.t_RADIO_REGIONAL_RDS[1],
                    showRadioBtn: true,
                    eventData: { setName: "RegionalRDS", setValue: Consts.t_RADIO_REGIONAL_RDS[1] },
                    isChecked: scxmlBolero.settings.RegionalRDS === Consts.t_RADIO_REGIONAL_RDS[1],
                    keyCentered: false }
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



