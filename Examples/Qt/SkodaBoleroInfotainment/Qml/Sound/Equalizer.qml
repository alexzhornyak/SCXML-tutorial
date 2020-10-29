import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts

Rectangle {
    id: equalRect

    border.color: AppConsts.cl_ITEM_BORDER

    color: AppConsts.cl_ITEM_COLOR

    readonly property int buttonWidth: 60

    property alias equalizerCaption: equalText.text

    SelectButton {
        id: plusBtn

        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.top: parent.top
        anchors.topMargin: 4

        anchors.left: valueSlider.right
        anchors.leftMargin: 20
        height: 50

        contentItem: Text {
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            style: Text.Outline
            color: AppConsts.cl_ITEM_TEXT
            font.family: "Tahoma"
            font.pixelSize: 20

            text: "+"
        }
    }

    SelectButton {
        id: minusBtn

        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4

        anchors.left: valueSlider.right
        anchors.leftMargin: 20
        height: 50

        contentItem: Text {
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            style: Text.Outline
            color: AppConsts.cl_ITEM_TEXT
            font.family: "Tahoma"
            font.pixelSize: 20

            text: "–"
        }
    }

    Text {
        id: equalText

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: valueSlider.right
        anchors.leftMargin: 20

        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        style: Text.Outline
        color: AppConsts.cl_ITEM_TEXT
        font.family: "Tahoma"
        font.pixelSize: 18
    }

    ColumnLayout {
        id: columnText

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: valueSlider.handle.height / 2 - 8
        anchors.bottomMargin: valueSlider.handle.height / 2 - 4

        width: 35

        Repeater {
            id: repeaterTicktext
            model: ["+9", "0", "-9"]

            Text {
                horizontalAlignment: Text.AlignRight
                verticalAlignment: index === 1 ? Text.AlignVCenter :
                                                 index === 0 ? Text.AlignTop :
                                                               Text.AlignBottom
                style: Text.Outline
                color: AppConsts.cl_ITEM_TEXT
                font.family: "Tahoma"
                font.pixelSize: 18

                text: modelData

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    Slider {
        id: valueSlider

        anchors.left: columnText.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        width: equalRect.buttonWidth

        /* Slider min-max differs from radio receiver min-max ! */

        leftPadding: 6
        topPadding: 4

        Component.onCompleted: {
//            /* 'value = scxmlBolero.getCurrentRadioFreq()' does not work for Slider */
//            scxmlBolero.settingsChanged.connect(function(){
//                value = scxmlBolero.getCurrentRadioFreq()
//            })
        }

        onMoved: {
//            var wasValue = value

//            var dMin = scxmlBolero.bandTypeFM ? Consts.d_RADIO_FM_MIN :
//                                                Consts.d_RADIO_AM_MIN
//            var dMax = scxmlBolero.bandTypeFM ? Consts.d_RADIO_FM_MAX :
//                                                Consts.d_RADIO_AM_MAX

//            /* set value here, otherwise Slider may set position out of limit */
//            value = Consts.limitMinMax(value, dMin, dMax)

//            scxmlBolero.submitEvent("Inp.App.Radio.SetFreq", value)
        }

        orientation: Qt.Vertical

        //readonly property real bandStep: scxmlBolero.bandTypeFM ? d_FM_STEP : d_AM_STEP

        from: +9
        to: -9
        stepSize: 1

        background: Item {
            Repeater {
                id: repeaterTickmarks
                model: valueSlider.stepSize > 0 ? 1 + (valueSlider.from - valueSlider.to) / valueSlider.stepSize : 0

                Rectangle {
                    color: AppConsts.cl_ITEM_BORDER
                    opacity: index === (valueSlider.from - valueSlider.to)/2 ? 1.0 : 0.5
                    width: equalRect.buttonWidth ; height: 3
                    y: valueSlider.topPadding - height/2.0 + valueSlider.handle.height / 2 +
                       index * ((valueSlider.availableHeight - valueSlider.handle.height) /
                                (repeaterTickmarks.count-1))
                    x: valueSlider.leftPadding
                }
            }
        }

        handle: Rectangle {
            id: backRectangle

            x: valueSlider.leftPadding// + valueSlider.availableWidth / 2 - width / 2
            y: valueSlider.topPadding + valueSlider.visualPosition * (valueSlider.availableHeight - height)
            implicitWidth: valueSlider.width
            implicitHeight: valueSlider.availableHeight / 18 * 4

            Rectangle {
                id: middleMarker
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                width: parent.width - 4
                height: 4

                color: AppConsts.cl_SELECTION
            }

            Rectangle {
                id: topBorderRect
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                border.color: valueSlider.pressed ? AppConsts.cl_SELECTION : AppConsts.cl_ITEM_BORDER

                height: 3
                visible: valueSlider.hovered
            }

            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: AppConsts.cl_ITEM_COLOR
                }

                GradientStop {
                    position: 0.05
                    color: valueSlider.pressed ? AppConsts.cl_SELECTION_OPACITY : AppConsts.cl_ITEM_COLOR
                }

                GradientStop {
                    position: 1
                    color: AppConsts.cl_ITEM_COLOR
                }
            }

            radius: 3
            border.width: valueSlider.pressed ? 2:1
            border.color: AppConsts.cl_ITEM_BORDER
        }
    }
}




