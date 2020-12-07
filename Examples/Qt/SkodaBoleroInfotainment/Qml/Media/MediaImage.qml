import QtQuick 2.12
import "qrc:/Qml"
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
        anchors.bottom: parent.bottom

        anchors.margins: 2

        antialiasing: true

        visible: scxmlBolero.audioInputAUX || scxmlBolero.mediaPlayerNormal

        /* do not use 'cache' ! because it does not update image immediately */
        cache: false

        function getMediaSourceImage() {
            fillMode = Image.Pad

            if (scxmlBolero.audioInputAUX)
                return "qrc:/Qml/Images/ImgAUX_128.png"

            if (scxmlBolero.audioInputDrives) {
                var url = fileUtils.urlFindFirstFile(audioPlayer.currentPlayUrlPath, ["*.jpg", "*.png"])
                if (url.toString()!=="") {
                    fillMode = Image.PreserveAspectFit
                    return url
                }

                if (scxmlBolero.audioInputCD)
                    return "qrc:/Qml/Images/ImgMenuMedia.png"
                if (scxmlBolero.audioInputSD)
                    return "qrc:/Qml/Images/ImgSD_128.png"
                if (scxmlBolero.audioInputUSB)
                    return "qrc:/Qml/Images/ImgUSB_128.png"
            }

            return ""
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
            if (scxmlBolero.audioInputCD)
                return "CD"
            if (scxmlBolero.audioInputSD)
                return "SD"
            if (scxmlBolero.audioInputUSB)
                return "USB"
            if (scxmlBolero.audioInputAUX)
                return "AUX"

            return ""
        }

        text: getText()
    }
}
