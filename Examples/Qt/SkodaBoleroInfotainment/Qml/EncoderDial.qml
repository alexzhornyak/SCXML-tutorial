import QtQuick 2.9
import QtQuick.Controls 2.2
import Example 1.0

Item {
    id: encoder
    width: 125
    height: width

    property real centerX : (width / 2);
    property real centerY : (height / 2);

    property bool isOnOff: true

    Image {
        id: imgBackground
        source: "Images/ImgEncoder.png"
        anchors.fill: parent
        rotation: 0

        scale: pressArea.pressed ? d_BTN_SCALE : 1.0
        opacity: mouseRotateArea.containsMouse ? d_BTN_OPACITY : 1.0

        MouseArea {
            id: mouseRotateArea
            anchors.fill: parent
            hoverEnabled: true

            onPositionChanged:  {
                if (pressed) {
                    var point =  mapToItem (encoder, mouse.x, mouse.y);
                    var diffX = (point.x - encoder.centerX);
                    var diffY = -1 * (point.y - encoder.centerY);
                    var rad = Math.atan (diffY / diffX);
                    var deg = (rad * 180 / Math.PI);
                    if (diffX > 0 && diffY > 0) {
                        imgBackground.rotation = 90 - Math.abs (deg);
                    }
                    else if (diffX > 0 && diffY < 0) {
                        imgBackground.rotation = 90 + Math.abs (deg);
                    }
                    else if (diffX < 0 && diffY > 0) {
                        imgBackground.rotation = 270 + Math.abs (deg);
                    }
                    else if (diffX < 0 && diffY < 0) {
                        imgBackground.rotation = 270 - Math.abs (deg);
                    }
                }
            }

        }


        Image {
            id: imgPress
            width: 80
            height: width
            source: isOnOff ? "Images/BtnOnOff.png" : "Images/BtnEncoder.png"
            anchors.centerIn: imgBackground

            opacity: pressArea.containsMouse ? d_BTN_OPACITY : 1.0

            MaskedMouseArea {
                id: pressArea
                anchors.fill: parent
                alphaThreshold: 0.4
                maskSource: imgPress.source
            }
        }

    }

}
