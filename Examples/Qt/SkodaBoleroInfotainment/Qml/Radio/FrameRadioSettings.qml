import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts

FrameSettings {

    caption: qsTr(scxmlBolero.settings.BandType + " setup")

    contentData: [

        ScrollView {
            id: view

            anchors.fill: parent

            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.vertical.interactive: false

            GridLayout {
                id: viewLayout
                columns: 2
                columnSpacing: AppConsts.i_SETTINGS_GRID_SPACING
                rowSpacing: AppConsts.i_SETTINGS_GRID_SPACING

                width: view.availableWidth - AppConsts.i_SETTINGS_BUTTON_OFFSET

                SetupButton {
                    text: qsTr("Sound")
                    eventName: "Radio.Sound"
                    Layout.preferredWidth: viewLayout.width / 2
                }

                SetupButton {
                    text: qsTr("Scan")
                    eventName: "Radio.Scan"
                    Layout.preferredWidth: viewLayout.width / 2
                }

                SetupButton {
                    Layout.columnSpan: 2

                    text: qsTr("Arrow buttons")
                    eventName: "Radio.Arrows"

                    showValueText: true
                    valueText: qsTr(scxmlBolero.settings.RadioArrows)
                    valueTextMargin: AppConsts.i_SETTINGS_BUTTON_OFFSET + viewLayout.columnSpacing/2
                }

                SetupButton {
                    Layout.columnSpan: 2

                    text: qsTr("Traffic programme (TP)")
                    eventName: "Radio.Traffic"

                    showCheckBox: true
                    enabled: false
                    isChecked: scxmlBolero.settings.RadioTraffic === true
                }

                SetupButton {
                    text: qsTr("Delete presets")
                    eventName: "Radio.DeletePresets"
                }

                SetupButton {
                    text: qsTr("Station logos")
                    eventName: "Radio.StationLogos"
                }

                SetupButton {
                    text: qsTr("Radio text")
                    eventName: "Radio.Text"

                    showCheckBox: true
                    isChecked: scxmlBolero.settings.RadioText === true
                    visible: scxmlBolero.settings.BandType === "FM"
                }

                SetupButton {
                    text: qsTr("Advanced setup")
                    eventName: "Radio.Advanced"
                    visible: scxmlBolero.settings.BandType === "FM"
                }
            }

        }
    ]


}



