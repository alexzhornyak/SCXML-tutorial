import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import Example 1.0

Item {
    id: itemMainWidget
    width: 1397
    height: 743
    visible: true

    property real d_BTN_SCALE: 0.95
    property real d_BTN_OPACITY: 0.9

    Image {
        id: imageMainWidget
        anchors.fill: parent
        fillMode: Image.Pad
        source: "Images/MainWidget.png"

        Image {
            id: imgBtnRadio
            x: 85
            y: 91
            width: 186
            height: 83
            source: "Images/BtnRadio.png"

            scale: btnRadioArea.pressed ? d_BTN_SCALE : 1.0
            opacity: btnRadioArea.containsMouse ? d_BTN_OPACITY : 1.0

            MaskedMouseArea {
                id: btnRadioArea
                anchors.fill: parent
                alphaThreshold: 0.4
                maskSource: imgBtnRadio.source
            }
        }

        Image {
            id: imgBtnMedia
            x: 96
            y: 172
            width: 169
            height: 72
            source: "Images/BtnMedia.png"

            scale: btnMediaArea.pressed ? d_BTN_SCALE : 1.0
            opacity: btnMediaArea.containsMouse ? d_BTN_OPACITY : 1.0

            MaskedMouseArea {
                id: btnMediaArea
                anchors.fill: parent
                alphaThreshold: 0.4
                maskSource: imgBtnMedia.source
            }
        }

        Image {
            id: imgBtnPhone
            x: 107
            y: 248
            width: 158
            height: 71
            source: "Images/BtnPhone.png"

            scale: btnPhoneArea.pressed ? d_BTN_SCALE : 1.0
            opacity: btnPhoneArea.containsMouse ? d_BTN_OPACITY : 1.0

            MaskedMouseArea {
                id: btnPhoneArea
                anchors.fill: parent
                alphaThreshold: 0.4
                maskSource: imgBtnPhone.source
            }
        }

        Image {
            id: imgBtnVoice
            x: 120
            y: 322
            width: 145
            height: 70
            source: "Images/BtnVoice.png"

            scale: btnVoiceArea.pressed ? d_BTN_SCALE : 1.0
            opacity: btnVoiceArea.containsMouse ? d_BTN_OPACITY : 1.0

            MaskedMouseArea {
                id: btnVoiceArea
                anchors.fill: parent
                alphaThreshold: 0.4
                maskSource: imgBtnVoice.source
            }
        }

        Image {
            id: imgBtnSetup
            x: 1131
            y: 96
            width: 176
            height: 74
            source: "Images/BtnSetup.png"

            scale: btnSetupArea.pressed ? d_BTN_SCALE : 1.0
            opacity: btnSetupArea.containsMouse ? d_BTN_OPACITY : 1.0

            MaskedMouseArea {
                id: btnSetupArea
                anchors.fill: parent
                alphaThreshold: 0.4
                maskSource: imgBtnSetup.source
            }
        }

        Image {
            id: imgBtnSound
            x: 1127
            y: 168
            width: 178
            height: 82
            source: "Images/BtnSound.png"

            scale: btnSoundArea.pressed ? d_BTN_SCALE : 1.0
            opacity: btnSoundArea.containsMouse ? d_BTN_OPACITY : 1.0

            MaskedMouseArea {
                id: btnSoundArea
                anchors.fill: parent
                alphaThreshold: 0.4
                maskSource: imgBtnSound.source
            }
        }

        Image {
            id: imgBtnCar
            x: 1127
            y: 243
            width: 168
            height: 82
            source: "Images/BtnCar.png"

            scale: btnCarArea.pressed ? d_BTN_SCALE : 1.0
            opacity: btnCarArea.containsMouse ? d_BTN_OPACITY : 1.0

            MaskedMouseArea {
                id: btnCarArea
                anchors.fill: parent
                alphaThreshold: 0.4
                maskSource: imgBtnCar.source
            }
        }

        Image {
            id: imgBtnMenu
            x: 1127
            y: 317
            width: 155
            height: 80
            source: "Images/BtnMenu.png"

            scale: btnMenuArea.pressed ? d_BTN_SCALE : 1.0
            opacity: btnMenuArea.containsMouse ? d_BTN_OPACITY : 1.0

            MaskedMouseArea {
                id: btnMenuArea
                anchors.fill: parent
                alphaThreshold: 0.4
                maskSource: imgBtnMenu.source
            }
        }

        EncoderDial {
            id: dialOnOff
            x: 155
            y: 460
            isOnOff: true
        }

        EncoderDial {
            id: dialSelect
            x: 1117
            y: 460
            isOnOff: false
        }

        Item {
            id: item1
            x: 401
            y: 119
            width: 594
            height: 354
        }
    }
}
