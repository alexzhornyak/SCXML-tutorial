import QtQuick 2.9
import QtQuick.Controls 2.2
import MaskedMouseArea 1.0

Item {
    id: encoder
    width: 125
    height: width

    property real centerX : (width / 2);
    property real centerY : (height / 2);

    property string name: ""

    // default 3.0 (greater => rotate faster, less => rotate slower)
    // inversion changes rotation direction
    property alias wheelRatio: mouseRotateArea.wheelRatio

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

            property real wheelRatio: 3.0

            function submitRotation(wasRotation) {
                var deltaRot = imgBackground.rotation - wasRotation

                if (deltaRot != 0.0) {

                    if (deltaRot > 180.0) {
                        deltaRot -= 360.0
                    } else if (deltaRot < -180.0) {
                        deltaRot += 360.0
                    }

                    scxmlBolero.submitEvent("Inp.Rotate." + encoder.name, deltaRot)
                }
            }

            onPositionChanged:  {
                if (pressed) {
                    var point =  mapToItem (encoder, mouse.x, mouse.y);
                    var diffX = (point.x - encoder.centerX);
                    var diffY = -1 * (point.y - encoder.centerY);
                    var rad = Math.atan (diffY / diffX);
                    var deg = (rad * 180 / Math.PI);
                    var wasRotation = imgBackground.rotation
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

                    submitRotation(wasRotation)
                }
            }

            onWheel: {
                var wasRotation = imgBackground.rotation
                wasRotation -= (wheel.angleDelta.y / 120.0) * wheelRatio
                if (wasRotation > 360.0) {
                    wasRotation -= 360.0
                } else if (wasRotation < 0) {
                    wasRotation += 360.0
                }

                imgBackground.rotation = wasRotation

                submitRotation(wasRotation)
            }

        }


        Image {
            id: imgPress
            width: 80
            height: width
            source: "Images/Btn" + encoder.name + ".png"
            anchors.centerIn: imgBackground

            opacity: pressArea.containsMouse ? d_BTN_OPACITY : 1.0

            MaskedMouseArea {
                id: pressArea
                anchors.fill: parent
                alphaThreshold: 0.4
                maskSource: imgPress.source

                onPressedChanged: scxmlBolero.submitEvent("Inp.Enc." + encoder.name,
                                                          pressed ? 1 : 0)
            }
        }

    }

}
