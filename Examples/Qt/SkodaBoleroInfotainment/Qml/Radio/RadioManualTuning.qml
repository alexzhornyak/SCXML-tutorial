import QtQuick 2.0
import QtQuick.Controls 2.12
import QtScxml 5.8
import "qrc:/Qml"
import "qrc:/Qml/AppConstants.js" as AppConsts
import "qrc:/Model/CommonConstants.js" as Consts

Rectangle {
    id: manualTuning

    color: AppConsts.cl_BACKGROUND

    Item {
        id: content
        anchors.fill: parent
        anchors.leftMargin: AppConsts.i_DISPLAY_PADDING
        anchors.rightMargin: AppConsts.i_DISPLAY_PADDING
        anchors.bottomMargin: AppConsts.i_DISPLAY_PADDING

        SelectDirectionButton {
            id: btnSelectLeft
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 80
            topBorderVisible: true
            isLeftDirection: true

            onPressedChanged: scxmlBolero.submitEvent("Inp.App.Radio.BtnTune.Left", btnSelectLeft.pressed ? 1:0 )
        }

        SelectDirectionButton {
            id: btnSelectRight
            width: 80
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            topBorderVisible: true
            isLeftDirection: false

            onPressedChanged: scxmlBolero.submitEvent("Inp.App.Radio.BtnTune.Right", btnSelectRight.pressed ? 1:0 )
        }

        Slider {
            id: freqSlider

            anchors.left: btnSelectLeft.right
            anchors.right: btnSelectRight.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            /* Slider min-max differs from radio receiver min-max ! */
            readonly property real d_FM_MIN: 88.0 * 1000000
            readonly property real d_FM_MAX: 108.0 * 1000000
            readonly property real d_FM_STEP: (d_FM_MAX - d_FM_MIN) / 10.0
            readonly property real d_AM_MIN: 540.0 * 1000
            readonly property real d_AM_MAX: 1600.0 * 1000
            readonly property real d_AM_STEP: (d_AM_MAX - d_AM_MIN) / 10.0

            Component.onCompleted: {
                /* 'value = scxmlBolero.getCurrentRadioFreq()' does not work for Slider */
                scxmlBolero.settingsChanged.connect(function(){
                    value = scxmlBolero.getCurrentRadioFreq()
                })
            }

            onMoved: {
                var wasValue = value

                var dMin = scxmlBolero.bandTypeFM ? Consts.d_RADIO_FM_MIN :
                                                    Consts.d_RADIO_AM_MIN
                var dMax = scxmlBolero.bandTypeFM ? Consts.d_RADIO_FM_MAX :
                                                    Consts.d_RADIO_AM_MAX

                /* set value here, otherwise Slider may set position out of limit */
                value = Consts.limitMinMax(value, dMin, dMax)

                scxmlBolero.submitEvent("Inp.App.Radio.SetFreq", value)
            }

            leftPadding: 6
            rightPadding: 2

            readonly property real bandStep: scxmlBolero.bandTypeFM ? d_FM_STEP : d_AM_STEP

            from: scxmlBolero.bandTypeFM ? (d_FM_MIN - d_FM_STEP) :
                                           (d_AM_MIN - d_AM_STEP)
            to: scxmlBolero.bandTypeFM ? (d_FM_MAX + d_FM_STEP) :
                                         (d_AM_MAX + d_AM_STEP)
            stepSize: bandStep / 20.0

            background: Canvas {
                id: radioScaleCanvas
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()

                    ctx.font = "16px tahoma"
                    ctx.textAlign = "center"
                    ctx.textBaseline = "top"

                    var ratio = freqSlider.availableWidth / 56

                    var curFreq = freqSlider.from - (scxmlBolero.bandTypeFM ? freqSlider.d_FM_STEP : freqSlider.d_AM_STEP)
                    for (var i=0;i<56;i++) {
                        ctx.fillStyle = (i % 4 === 0 && i>4 && i<52) ? AppConsts.cl_ITEM_BORDER : AppConsts.cl_BACKGROUND_LIGHT

                        var x1 = freqSlider.leftPadding + i * ratio - 1
                        var y1 = freqSlider.topPadding + 10
                        var w = 3
                        var h = 20

                        var textFreq = undefined

                        if (i>4 && i<52) {
                            if (i % 8 === 0) {
                                h = 28
                                y1 -= 4

                                curFreq += scxmlBolero.bandTypeFM ? freqSlider.d_FM_STEP*2 : freqSlider.d_AM_STEP*2
                                textFreq = curFreq

                            } else if (i % 4 === 0) {
                                h = 24
                                y1 -= 2
                            }
                        }

                        ctx.fillRect(x1, y1, w, h)

                        if (textFreq !== undefined) {
                            ctx.fillStyle = AppConsts.cl_ITEM_TEXT

                            textFreq = scxmlBolero.bandTypeFM ? textFreq / 1000000 : textFreq / 1000

                            if (scxmlBolero.bandTypeAM) {
                                textFreq = Math.trunc(textFreq / 10.0)*10.0
                            }

                            ctx.fillText(textFreq.toFixed(), x1, y1 + h)
                        }
                    }

                    /* top horizontal line */
                    ctx.fillStyle = AppConsts.cl_ITEM_BORDER
                    ctx.fillRect(0,2,freqSlider.width,2)
                }

                Component.onCompleted: {
                    scxmlBolero.onBandTypeAMChanged.connect(updateCanvasOnBandChanged)
                    scxmlBolero.onBandTypeFMChanged.connect(updateCanvasOnBandChanged)
                }

                function updateCanvasOnBandChanged(active) {
                    if (active) {
                        freqSlider.value = scxmlBolero.getCurrentRadioFreq()
                        radioScaleCanvas.requestPaint()
                    }
                }
            }

            handle: Rectangle {
                id: backRectangle

                x: freqSlider.leftPadding + freqSlider.visualPosition * (freqSlider.availableWidth - width)
                y: freqSlider.topPadding + freqSlider.availableHeight / 2 - height / 2
                implicitWidth: freqSlider.availableWidth / 56 * 8
                implicitHeight: freqSlider.availableHeight

                Rectangle {
                    id: middleMarker
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    width: 2
                    height: parent.height - 4

                    color: AppConsts.cl_SELECTION
                }

                Rectangle {
                    id: topBorderRect
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    border.color: freqSlider.pressed ? AppConsts.cl_SELECTION : AppConsts.cl_ITEM_BORDER

                    height: 3
                    visible: freqSlider.hovered
                }

                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: AppConsts.cl_ITEM_COLOR
                    }

                    GradientStop {
                        position: 0.05
                        color: freqSlider.pressed ? AppConsts.cl_SELECTION_OPACITY : AppConsts.cl_ITEM_COLOR
                    }

                    GradientStop {
                        position: 1
                        color: AppConsts.cl_ITEM_COLOR
                    }
                }

                radius: 3
                border.width: freqSlider.pressed ? 2:1
                border.color: AppConsts.cl_ITEM_BORDER
            }
        }

    }
}
