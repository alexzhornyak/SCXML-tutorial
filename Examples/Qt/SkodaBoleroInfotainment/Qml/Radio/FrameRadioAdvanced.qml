import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts

FrameSettings {

    caption: qsTr("Advanced setup")

    viewLayout.columns: 1

    repeater.model: [

        {
            text: "Alternative frequency (AF)",
            eventName: "Radio.AF",
            showCheckBox: true
        },
        {
            text: "Radio Data System (RDS)",
            eventName: "Radio.RDS",
            showCheckBox: true
        },
        {
            text: "RDS Regional",
            eventName: "Radio.RegionalRDS",
            valueText: scxmlBolero.settings.RegionalRDS
        },
        {
            text: "Auto-save station logos",
            eventName: "Radio.AutoSaveLogos",
            enabled: false,
            isChecked: scxmlBolero.settings.RadioTraffic === true
        }
    ]

}



