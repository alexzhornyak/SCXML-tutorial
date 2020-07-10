import QtQuick 2.7
import QtQuick.Controls 2.2

Item {
    id: itemMainWidget
    width: 1397
    height: 743
    visible: true    

    property alias container: display

    Rectangle {
        id: display
        x: 398
        y: 117
        width: 600
        height: 360
        color: "#434449"
    }

    Image {
        id: imageMainWidget
        fillMode: Image.Pad
        source: "Images/MainWidget.png"

        DeviceButton {
            id: imgBtnRadio
            name: "Radio"
            x: 85
            y: 91
            width: 186
            height: 83
        }

        DeviceButton {
            id: imgBtnMedia
            name: "Media"
            x: 96
            y: 172
            width: 169
            height: 72
        }

        DeviceButton {
            id: imgBtnMute
            name: "Mute"
            x: 107
            y: 248
            width: 158
            height: 71
        }

        DeviceButton {
            id: imgBtnTP
            name: "TP"
            x: 120
            y: 322
            width: 145
            height: 70
        }

        DeviceButton {
            id: imgBtnSetup
            name: "Setup"
            x: 1131
            y: 96
            width: 176
            height: 74
        }

        DeviceButton {
            id: imgBtnSound
            name: "Sound"
            x: 1127
            y: 168
            width: 178
            height: 82
        }

        DeviceButton {
            id: imgBtnCar
            name: "Car"
            x: 1127
            y: 243
            width: 168
            height: 82
        }

        DeviceButton {
            id: imgBtnMenu
            name: "Menu"
            x: 1127
            y: 317
            width: 155
            height: 80
        }

        EncoderDial {
            id: dialOnOff
            name: "OnOff"
            x: 155
            y: 460
        }

        EncoderDial {
            id: dialSelect
            name: "Select"
            x: 1117
            y: 460
        }
    }
}
