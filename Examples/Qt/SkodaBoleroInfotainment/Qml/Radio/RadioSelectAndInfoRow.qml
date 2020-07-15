import QtQuick 2.0
import "../"
import "../BoleroConstants.js" as Consts

Item {
    id: rowTopSelect

    Text {
        id: info
        text: scxmlBolero.getCaption(scxmlBolero.getCurrentRadioFreq(), "26", "20")
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        textFormat: Text.RichText
        color: Consts.cl_ITEM_TEXT
        style: Text.Outline
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        font.family: "Tahoma"
        font.pixelSize: 26
    }

    SelectButton {
        id: btnSelectLeft
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 80

        Canvas {
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d");
                // the triangle
                context.beginPath();
                var edge = btnSelectLeft.width/8
                var centerX = btnSelectLeft.width/2
                var centerY = btnSelectLeft.height/2
                context.moveTo(centerX - edge, centerY);
                context.lineTo(centerX + edge, centerY - edge);
                context.lineTo(centerX + edge, centerY + edge);
                context.closePath();

                // the fill color
                context.fillStyle = Consts.cl_ITEM_TEXT;
                context.fill();
            }
        }
    }

    SelectButton {
        id: btnSelectRight
        width: 80
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        Canvas {
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d");
                // the triangle
                context.beginPath();
                var edge = btnSelectRight.width/8
                var centerX = btnSelectRight.width/2
                var centerY = btnSelectRight.height/2
                context.moveTo(centerX + edge, centerY);
                context.lineTo(centerX - edge, centerY - edge);
                context.lineTo(centerX - edge, centerY + edge);
                context.closePath();

                // the fill color
                context.fillStyle = Consts.cl_ITEM_TEXT;
                context.fill();
            }
        }
    }
}
