import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts

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
            enabled: scxmlBolero.settings.RadioRDS === true
        },
        {
            text: "Auto-save station logos",
            eventName: "Radio.AutoSaveLogos",
            eventData: { checkName: "RadioAutoSaveLogos" },
            enabled: scxmlBolero.settings.RadioRDS === true,
            isChecked: scxmlBolero.settings.RadioAutoSaveLogos === true
        }
    ]

}



