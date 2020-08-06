import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "AppConstants.js" as AppConsts

BoleroBackgroundRender {
    id: frameMenu
    clip: true

    ListModel {
        id: menuModel
        ListElement { name: "Radio"; image: "Images/ImgMenuRadio.png" }
        ListElement { name: "Media"; image: "Images/ImgMenuRadio.png" }
        ListElement { name: "Sound settings"; image: "Images/ImgMenuRadio.png" }
        ListElement { name: "Unit settings"; image: "Images/ImgMenuRadio.png" }
        ListElement { name: "Vehicle system settings"; image: "Images/ImgMenuRadio.png" }
    }

    Component {
        id: menuDelegate

        Rectangle {
            width: 190;
            height: width

            scale: PathView.elementScale
            z: PathView.elementZ

            readonly property bool itemSelected: view.currentIndex == index

            required property string name
            required property string image
            required property int index

            //z: itemSelected ? 1 : 0

            Rectangle {
                id: topBorderRect
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                border.color: (mouseArea.pressed || itemSelected) ? AppConsts.cl_SELECTION : AppConsts.cl_ITEM_BORDER

                height: 3
            }

            color: "gray"


            radius: 3
            border.width: (mouseArea.pressed || itemSelected) ? 3 : 1
            border.color: (mouseArea.pressed || itemSelected) ? AppConsts.cl_SELECTION : AppConsts.cl_ITEM_BORDER

            Image {
                anchors.centerIn: parent
                source: image
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: view.currentIndex = parent.index
            }
        }
    }

    Component {
        id: appHighlight
        Rectangle { width: 80; height: 80; color: "lightsteelblue" }
    }

    PathView {
        id: view
        anchors.fill: parent
        anchors.margins: AppConsts.i_DISPLAY_PADDING
        highlight: appHighlight
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true
        model: menuModel
        delegate: menuDelegate
        path: Path {
            id:flowViewPath

            readonly property real yCoord: view.height/2
            readonly property real xWidth: view.width

            startX: 0
            startY: flowViewPath.yCoord

            PathAttribute{name:"elementZ"; value: 0}
            PathAttribute{name:"elementScale"; value: 0.5}

            PathLine {
                x: flowViewPath.xWidth*0.5
                y: flowViewPath.yCoord
            }

            PathAttribute{name:"elementZ";value:100}
            PathAttribute{name:"elementScale";value:1.0}

            PathLine {
                x: flowViewPath.xWidth
                y: flowViewPath.yCoord
            }

            PathAttribute{name:"elementZ";value:0}
            PathAttribute{name:"elementScale";value:0.5}
        }
    }
}
