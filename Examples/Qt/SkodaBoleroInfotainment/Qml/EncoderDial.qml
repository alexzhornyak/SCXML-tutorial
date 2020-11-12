import QtQuick 2.9
import QtQuick.Controls 2.2
import MaskedMouseArea 1.0
import "AppConstants.js" as AppConsts

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

        scale: pressArea.pressed ? AppConsts.d_BTN_SCALE : 1.0
        opacity: mouseRotateArea.containsMouse ? AppConsts.d_BTN_OPACITY : 1.0

        MouseArea {
            id: mouseRotateArea
            anchors.fill: parent
            hoverEnabled: true

            readonly property real wheelRatio: 3.0
            readonly property int maxPositionSends: 5
            property int positionSendsCount: 0

            onPositionChanged:  {
                if (pressed && !pressArea.containsMouse) {
                    var point =  mapToItem (encoder, mouse.x, mouse.y);
                    var diffX = (point.x - encoder.centerX);
                    var diffY = -1 * (point.y - encoder.centerY);
                    var rad = Math.atan (diffY / diffX);
                    var deg = (rad * 180 / Math.PI);

                    var dRotation = imgBackground.rotation;

                    if (diffX > 0 && diffY > 0) {
                        dRotation = 90 - Math.abs (deg);
                    }
                    else if (diffX > 0 && diffY < 0) {
                        dRotation = 90 + Math.abs (deg);
                    }
                    else if (diffX < 0 && diffY > 0) {
                        dRotation = 270 + Math.abs (deg);
                    }
                    else if (diffX < 0 && diffY < 0) {
                        dRotation = 270 - Math.abs (deg);
                    }

                    var deltaRot = imgBackground.rotation - dRotation
                    if (deltaRot !== 0.0) {

                        if (deltaRot > 180.0) {
                            deltaRot -= 360.0
                        } else if (deltaRot < -180.0) {
                            deltaRot += 360.0
                        }

                        positionSendsCount++

                        if (positionSendsCount>maxPositionSends) {
                            positionSendsCount=0

                            deltaRot = (deltaRot>0 ? -1 : 1) * wheelRatio

                            scxmlBolero.submitEvent("Inp.Rotate." + encoder.name, deltaRot)
                        }

                    }

                    imgBackground.rotation = dRotation
                }
            }

            onWheel: {
                var dRotation = imgBackground.rotation

                var dDeltaRot = (wheel.angleDelta.y / 120.0) * wheelRatio

                dRotation += dDeltaRot
                if (dRotation > 360.0) {
                    dRotation -= 360.0
                } else if (dRotation < 0) {
                    dRotation += 360.0
                }

                imgBackground.rotation = dRotation

                if (dDeltaRot) {
                    scxmlBolero.submitEvent("Inp.Rotate." + encoder.name, dDeltaRot)
                }
            }

        }


        Image {
            id: imgPress
            width: 80
            height: width
            source: "Images/Btn" + encoder.name + ".png"
            anchors.centerIn: imgBackground

            opacity: pressArea.containsMouse ? AppConsts.d_BTN_OPACITY : 1.0

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
