import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "BoleroConstants.js" as Consts

Button {
    id: button

    property bool itemSelected: false
    property bool topBorderVisible: true

    property string gradientColor: Consts.cl_ITEM_COLOR

    Layout.fillWidth: true
    Layout.fillHeight: true

    background: Rectangle {
        id: backRectangle

        Rectangle {
            id: topBorderRect
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            border.color: (button.pressed || itemSelected) ? Consts.cl_SELECTION : Consts.cl_ITEM_BORDER

            height: 3
            visible: topBorderVisible
        }

        gradient: Gradient {
            GradientStop {
                position: 0
                color: Consts.cl_ITEM_COLOR
            }

            GradientStop {
                position: 0.05
                color: button.pressed ? Consts.cl_SELECTION_OPACITY : gradientColor
            }

            GradientStop {
                position: 1
                color: Consts.cl_ITEM_COLOR
            }
        }

        radius: 3
        border.width: (button.pressed || itemSelected) ? 3 : 1
        border.color: (button.pressed || itemSelected) ? Consts.cl_SELECTION : Consts.cl_ITEM_BORDER
    }

}
