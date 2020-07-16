import QtQuick 2.0
import "BoleroConstants.js" as Consts

SelectButton {
    id: btnSelectDirection

    property bool isLeftDirection: true

    Canvas {
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            // the triangle
            context.beginPath();
            var edge = btnSelectLeft.width/8
            var centerX = btnSelectLeft.width/2
            var centerY = btnSelectLeft.height/2

            var ratio = isLeftDirection ? 1 : -1

            context.moveTo(centerX - edge * ratio, centerY);
            context.lineTo(centerX + edge * ratio, centerY - edge);
            context.lineTo(centerX + edge * ratio, centerY + edge);
            context.closePath();

            // the fill color
            context.fillStyle = Consts.cl_ITEM_TEXT;
            context.fill();
        }
    }
}
