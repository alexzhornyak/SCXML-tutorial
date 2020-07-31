import QtQuick 2.0
import QtQuick.Layouts 1.12
import "AppConstants.js" as AppConsts

SelectButton {
    id: btnSetup

    highlightBackgroundWhenSelected: true
    text: qsTr(modelData.text)
    enabled: modelData.enabled === undefined ? true : modelData.enabled
    visible: modelData.visible === undefined ? true : modelData.visible

    property bool textKeyCentered: modelData.textKeyCentered === undefined ? false : modelData.textKeyCentered

    /* With CheckBox */
    property bool showCheckBox: modelData.isChecked !== undefined
    // we do not use native 'checked',
    // because it mustn't set on button clicked,
    // only through State Machine
    property bool isChecked: modelData.isChecked === undefined ? false : modelData.isChecked

    /* With ValueText */
    property bool showValueText: modelData.valueText !== undefined
    property string valueText: modelData.valueText === undefined ? "" : qsTr(modelData.valueText)
    property real valueTextMargin: modelData.valueTextMargin === undefined ? 0 : modelData.valueTextMargin

    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.preferredHeight: 50
    Layout.columnSpan: modelData.colSpan === undefined ? 1 : modelData.colSpan

    onEnabledChanged: opacity = enabled ? 1.0 : 0.5

    onReleased: scxmlBolero.submitBtnSetupEvent(modelData.eventName, modelData.eventData)

    contentItem: Item {
        anchors.fill: btnSetup

        Text {
            id: textKey
            anchors.left: textKeyCentered ? undefined : parent.left
            anchors.leftMargin: 20
            anchors.horizontalCenter: textKeyCentered ? parent.horizontalCenter : undefined
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            style: Text.Outline
            color: AppConsts.cl_ITEM_TEXT
            font.family: "Tahoma"
            font.pixelSize: 20

            text: btnSetup.text
        }

        Text {
            id: textValue
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2 + valueTextMargin
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            style: Text.Outline
            color: AppConsts.cl_ITEM_TEXT
            font.family: "Tahoma"
            font.pixelSize: 20

            visible: btnSetup.showValueText
            text: btnSetup.valueText
        }

        Image {
            visible: btnSetup.showCheckBox || btnSetup.showValueText

            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            fillMode: Image.Pad
            source: btnSetup.showCheckBox ? (btnSetup.isChecked ? "Images/ImgCheckMark.png" : "Images/ImgCheckRect.png") :
                                            "Images/ImgArrowDropDown.png"
        }
    }
}


