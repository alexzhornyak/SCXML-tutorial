import QtQuick 2.0
import "BoleroConstants.js" as Consts

Rectangle {

    property bool itemSelected: false

    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        border.color: (mouseArea.pressed || itemSelected) ? Consts.cl_SELECTION : Consts.cl_ITEM_BORDER

        height: 3
    }

    gradient: Gradient {
        GradientStop {
            position: 0
            color: Consts.cl_ITEM_COLOR
        }

        GradientStop {
            position: 0.1
            color: mouseArea.pressed ? Consts.cl_SELECTION_OPACITY : Consts.cl_ITEM_COLOR
        }

        GradientStop {
            position: 1
            color: Consts.cl_ITEM_COLOR
        }
    }

    radius: 3
    border.width: (mouseArea.pressed || itemSelected) ? 2 : 1
    border.color: (mouseArea.pressed || itemSelected) ? Consts.cl_SELECTION : Consts.cl_ITEM_BORDER

    MouseArea {
        id: mouseArea

        anchors.fill: parent
    }
}
