import QtQuick 2.0
import QtQuick.Controls 2.12
import "../"
import "../BoleroConstants.js" as Consts

Rectangle {
    id: manualTuning

    color: Consts.cl_BACKGROUND

    Item {
        id: content
        anchors.fill: parent
        anchors.leftMargin: Consts.i_DISPLAY_PADDING
        anchors.rightMargin: Consts.i_DISPLAY_PADDING
        anchors.bottomMargin: Consts.i_DISPLAY_PADDING

        SelectDirectionButton {
            id: btnSelectLeft
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 80
            topBorderVisible: true
            isLeftDirection: true

            onClicked: freqSlider.decrease()
        }

        SelectDirectionButton {
            id: btnSelectRight
            width: 80
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            topBorderVisible: true
            isLeftDirection: false

            onClicked: freqSlider.increase()
        }

        Slider {
            id: freqSlider

            anchors.left: btnSelectLeft.right
            anchors.right: btnSelectRight.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            //snapMode: Slider.SnapAlways

            value: scxmlBolero.getCurrentRadioFreq()

            onMoved: {
                var dMin = scxmlBolero.bandTypeFM ? Consts.d_RADIO_FM_MIN : Consts.d_RADIO_AM_MIN
                var dMax = scxmlBolero.bandTypeFM ? Consts.d_RADIO_FM_MAX : Consts.d_RADIO_AM_MAX

                value = Consts.limitMinMax(value, dMin, dMax)

                scxmlBolero.submitRadioFreq(value)
            }

            leftPadding: 6
            rightPadding: 2

            from: scxmlBolero.bandTypeFM ? 86.0 : 542
            to: scxmlBolero.bandTypeFM ? 110.0 : 1022
            stepSize: 0.1

            background: Canvas {
                id: radioScaleCanvas
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()

                    ctx.font = "16px tahoma"
                    ctx.textAlign = "center"
                    ctx.textBaseline = "top"

                    var ratio = freqSlider.availableWidth / 56

                    var curFreq = scxmlBolero.bandTypeFM ? 84 : 540
                    for (var i=0;i<56;i++) {
                        ctx.fillStyle = (i % 4 === 0 && i>4 && i<52) ? Consts.cl_ITEM_BORDER : Consts.cl_BACKGROUND_LIGHT

                        var x1 = freqSlider.leftPadding + i * ratio - 1
                        var y1 = freqSlider.topPadding + 10
                        var w = 3
                        var h = 20

                        var textFreq = undefined

                        if (i>4 && i<52) {
                            if (i % 8 === 0) {
                                h = 28
                                y1 -= 4

                                curFreq += scxmlBolero.bandTypeFM ? 4 : 100
                                textFreq = curFreq

                            } else if (i % 4 === 0) {
                                h = 24
                                y1 -= 2
                            }
                        }

                        ctx.fillRect(x1, y1, w, h)

                        if (textFreq !== undefined) {
                            ctx.fillStyle = Consts.cl_ITEM_TEXT
                            ctx.fillText(textFreq.toFixed(), x1, y1 + h)
                        }
                    }

                    /* top horizontal line */
                    ctx.fillStyle = Consts.cl_ITEM_BORDER
                    ctx.fillRect(0,2,freqSlider.width,2)
                }

                Component.onCompleted: {
                    scxmlBolero.onBandTypeAMChanged.connect(updateCanvasOnBandChanged)
                    scxmlBolero.onBandTypeFMChanged.connect(updateCanvasOnBandChanged)
                }

                function updateCanvasOnBandChanged(active) {
                    if (active) {
                        radioScaleCanvas.requestPaint()
                    }
                }
            }

            handle: Rectangle {
                id: backRectangle

                x: freqSlider.leftPadding + freqSlider.visualPosition * (freqSlider.availableWidth - width)// + 2 /* tickWidth */
                y: freqSlider.topPadding + freqSlider.availableHeight / 2 - height / 2
                implicitWidth: freqSlider.availableWidth / 56 * 8
                implicitHeight: freqSlider.availableHeight

                Rectangle {
                    id: middleMarker
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    width: 2
                    height: parent.height - 4

                    color: Consts.cl_SELECTION
                }

                Rectangle {
                    id: topBorderRect
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    border.color: freqSlider.pressed ? Consts.cl_SELECTION : Consts.cl_ITEM_BORDER

                    height: 3
                    visible: freqSlider.hovered
                }

                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: Consts.cl_ITEM_COLOR
                    }

                    GradientStop {
                        position: 0.05
                        color: freqSlider.pressed ? Consts.cl_SELECTION_OPACITY : Consts.cl_ITEM_COLOR
                    }

                    GradientStop {
                        position: 1
                        color: Consts.cl_ITEM_COLOR
                    }
                }

                radius: 3
                border.width: freqSlider.pressed ? 2:1
                border.color: Consts.cl_ITEM_BORDER
            }
        }

    }
}
