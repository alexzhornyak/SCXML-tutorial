import QtQuick 2.12
import QtQuick.Shapes 1.15
import "qrc:/Qml"
import "qrc:/Qml/AppConstants.js" as AppConsts

SelectButton {
    topBorderVisible: scxmlBolero.mediaAccentOn

    onReleased: scxmlBolero.submitBtnSetupEvent("MediaFunc.Scan")

    Shape {
        id: shape
        anchors.fill: parent

        visible: scxmlBolero.mediaPlayerScanModeOn

        ShapePath {
            id: shapePath
            strokeColor: "red"
            strokeWidth: 3
            fillColor: "red"
            capStyle: ShapePath.RoundCap

            readonly property int iOffset: 7

            startX: iOffset; startY: shape.height - iOffset
            PathLine { x: shape.width - shapePath.iOffset; y: shapePath.iOffset }
        }
    }

    Text {
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        style: Text.Outline
        color: AppConsts.cl_ITEM_TEXT
        font.family: "Tahoma"
        font.pixelSize: 24

        text: "SCAN" /* do not translate */
    }
}
