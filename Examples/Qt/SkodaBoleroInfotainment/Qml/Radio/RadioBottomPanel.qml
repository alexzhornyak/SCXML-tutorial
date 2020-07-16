import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import "../"
import "../BoleroConstants.js" as Consts

Item {
    id: bottomPanel

    RowLayout {
        id: rowButtons
        anchors.fill: parent
        spacing: 3

        clip: true

        Repeater {
            id: repeaterButtons
            model: [    { name: "Band" }, //special case: 'FM' or 'AM' text
                        { name: "Stations", img: "../Images/RadioStations.png" },
                        { name: "Manual", img: "../Images/RadioManual.png" },
                        { name: "Setup", img: "../Images/ImgBtnSettings.png"}
            ]

            delegate: FocusButton {
                name: modelData.name
                text: qsTr(modelData.name)
                imageSource: index!=0 ? modelData.img : imageSource
                imageVisible: index!=0
            }
        }
    }

    Rectangle {
        id: manualTuning
        visible: scxmlBolero.radioTuneFreqOn

        anchors.fill: parent

        color: Consts.cl_BACKGROUND

        SelectDirectionButton {
            id: btnSelectLeft
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 80
            topBorderVisible: true
            isLeftDirection: true
        }

        SelectDirectionButton {
            id: btnSelectRight
            width: 80
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            topBorderVisible: true
            isLeftDirection: false
        }

        Slider {
            id: freqSlider

            anchors.left: btnSelectLeft.right
            anchors.right: btnSelectRight.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            padding: 4

            from: 87.5
            to: 108.0
            stepSize: 0.1

            background: /*Rectangle {
                x: freqSlider.leftPadding
                y: freqSlider.topPadding + freqSlider.availableHeight / 2 - height / 2
                implicitWidth: 200
                implicitHeight: 4
                width: freqSlider.availableWidth
                height: implicitHeight
                radius: 2
                color: "#bdbebf"

                Rectangle {
                    width: freqSlider.visualPosition * parent.width
                    height: parent.height
                    color: "#21be2b"
                    radius: 2
                }
            }*/

            Canvas {
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()

                    ctx.font = "16px tahoma"
                    ctx.textAlign = "center"
                    ctx.textBaseline = "top"
                    var ratio = (freqSlider.availableWidth - freqSlider.leftPadding) / 55

                    var curFreq = 84
                    for (var i=0;i<56;i++) {
                        ctx.fillStyle = (i % 4 === 0 && i>4 && i<52) ? Consts.cl_ITEM_BORDER : Consts.cl_BACKGROUND_LIGHT

                        var x1 = freqSlider.leftPadding + i * ratio
                        var y1 = freqSlider.topPadding + 10
                        var w = 3
                        var h = 20

                        var textFreq = undefined

                        if (i>4 && i<52) {
                            if (i % 8 === 0) {
                                h = 28
                                y1 -= 4

                                curFreq += 4
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

                    ctx.fillStyle = Consts.cl_ITEM_BORDER
                    ctx.fillRect(0,2,freqSlider.width,2)


                }
            }
//                Repeater {
//                            id: repeater
//                            model: 56
//                            Rectangle {
//                                // visible: index !=0 && index!=55
//                                color: (index % 4 === 0 && index>4 && index<52) ? Consts.cl_ITEM_TEXT : Consts.cl_BACKGROUND_LIGHT
//                                width: 3 ; height: freqSlider.availableHeight / 2
//                                y: freqSlider.topPadding + 4
//                                x: freqSlider.leftPadding + index * ((freqSlider.availableWidth - freqSlider.padding*2) / (repeater.count-1))
//                            }
//                        }

//            RowLayout {
//                height: freqSlider.availableHeight
//                width: freqSlider.availableWidth
//                Repeater {
//                    model: 56
//                    delegate: Rectangle {
//                        width: 2
//                        height: freqSlider.height / 2

//                        color: Consts.cl_BACKGROUND_LIGHT
//                    }
//                }
//            }

            handle: Rectangle {
                x: freqSlider.leftPadding + freqSlider.visualPosition * (freqSlider.availableWidth - width)
                y: freqSlider.topPadding + freqSlider.availableHeight / 2 - height / 2
                implicitWidth: 26
                implicitHeight: 26
                //radius: 13
                color: freqSlider.pressed ? "#f0f0f0" : "#f6f6f6"
                border.color: "#bdbebf"
            }


        }
    }
}


