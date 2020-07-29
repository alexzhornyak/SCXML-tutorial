import QtQuick 2.0
import QtQuick.Layouts 1.12
import "AppConstants.js" as AppConsts

SelectButton {
    id: btnSetup

    property string eventName: ""

    /* With CheckBox */
    property bool showCheckBox: false
    // we do not use native 'checked',
    // because it mustn't set on button clicked,
    // only through State Machine
    property bool isChecked: false;

    /* With ValueText */
    property bool showValueText: false
    property string valueText: ""
    property real valueTextMargin: 0

    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.preferredHeight: 50

    onEnabledChanged: opacity = enabled ? 1.0 : 0.5

    onClicked: {
        if (eventName != "") {
            scxmlBolero.submitEvent("Inp.App.BtnSetup." + eventName)
        }
    }

    contentItem: Item {
        anchors.fill: btnSetup

        Text {
            id: textKey
            anchors.left: parent.left
            anchors.leftMargin: 20
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


