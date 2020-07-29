import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts

FrameSettings {

    caption: qsTr("Advanced setup")

    contentData: [

        ScrollView {
            id: view

            anchors.fill: parent

            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.vertical.interactive: false

            ColumnLayout {
                id: viewLayout
                spacing: AppConsts.i_SETTINGS_GRID_SPACING

                width: view.availableWidth - AppConsts.i_SETTINGS_BUTTON_OFFSET

                SetupButton {
                    text: qsTr("Alternative frequency (AF)")
                    eventName: "Radio.Sound"
                    showCheckBox: true
                }

                SetupButton {
                    text: qsTr("Radio Data System (RDS)")
                    eventName: "Radio.Scan"
                    showCheckBox: true
                }

                SetupButton {
                    text: qsTr("RDS Regional")
                    eventName: "Radio.Arrows"

                    showValueText: true
                    valueText: qsTr(scxmlBolero.settings.RadioArrows)
                }

                SetupButton {
                    text: qsTr("Auto-save station logos")
                    eventName: "Radio.Traffic"

                    showCheckBox: true
                    enabled: false
                    isChecked: scxmlBolero.settings.RadioTraffic === true
                }
            }

        }
    ]


}



