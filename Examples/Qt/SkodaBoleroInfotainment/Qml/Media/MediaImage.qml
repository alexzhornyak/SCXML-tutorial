import QtQuick 2.12
import "qrc:/Qml/AppConstants.js" as AppConsts

Rectangle {
    id: background

    gradient: Gradient {
        GradientStop {
            position: 0
            color: AppConsts.cl_ITEM_HALFCOLOR
        }

        GradientStop {
            position: 1
            color: AppConsts.cl_ITEM_COLOR
        }
    }

    radius: 3
    border.width: 1
    border.color: AppConsts.cl_ITEM_BORDER

    clip: false

    Image {
        id: image

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: textCaption.top

        antialiasing: true

        /* do not use 'cache' ! because it does not update image immediately */
        cache: false

        function getMediaSourceImage() {
            if (scxmlBolero.audioSourceCD)
                return "qrc:/Qml/Images/ImgMenuMedia.png"
            if (scxmlBolero.audioSourceSD)
                return "qrc:/Qml/Images/ImgSD_128.png"
            if (scxmlBolero.audioSourceUSB)
                return "qrc:/Qml/Images/ImgUSB_128.png"
            if (scxmlBolero.audioSourceAUX)
                return "qrc:/Qml/Images/ImgAUX_128.png"

            return "" // mustn't occur
        }

        source: getMediaSourceImage()
        fillMode: Image.Pad
    }

    Text {
        id: textCaption

        anchors.left: parent.left
        anchors.leftMargin: 10

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4

        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        style: Text.Outline
        color: AppConsts.cl_ITEM_TEXT
        font.family: "Tahoma"
        font.pixelSize: 22

        function getText() {
            if (scxmlBolero.audioSourceCD)
                return "CD"
            if (scxmlBolero.audioSourceSD)
                return "SD"
            if (scxmlBolero.audioSourceUSB)
                return "USB"
            if (scxmlBolero.audioSourceAUX)
                return "AUX"

            return ""
        }

        text: getText()
    }
}
