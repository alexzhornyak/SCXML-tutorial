import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "AppConstants.js" as AppConsts
import "../Model/CommonConstants.js" as Consts

BoleroBackgroundRender {
    id: frameMenu
    clip: true

    Component {
        id: menuDelegate

        Rectangle {
            width: 190;
            height: width

            scale: PathView.elementScale
            z: PathView.elementZ

            readonly property bool itemSelected: view.currentIndex == index

            required property int index

            Rectangle {
                id: topBorderRect
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                border.color: (mouseArea.pressed || itemSelected) ? AppConsts.cl_SELECTION : AppConsts.cl_ITEM_BORDER

                height: 3
            }

            color: "gray"

            radius: 6
            border.width: (mouseArea.pressed || itemSelected) ? 3 : 1
            border.color: (mouseArea.pressed || itemSelected) ? AppConsts.cl_SELECTION : AppConsts.cl_ITEM_BORDER

            Image {
                anchors.centerIn: parent

                source: getImage()

                function getImage() {
                    var t_IMAGES = ["Images/ImgMenuRadio.png",
                                    "Images/ImgMenuMedia.png",
                                    "Images/ImgMenuSetup.png",
                                    "Images/ImgMenuVehicle.png"]

                    return t_IMAGES[view.gridData[parent.index]]
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: view.currentIndex = parent.index
            }
        }
    }

//    Component {
//        id: appHighlight
//        Rectangle { width: 80; height: 80; color: "lightsteelblue" }
//    }

    PathView {
        id: view
        anchors.fill: parent
        anchors.margins: AppConsts.i_DISPLAY_PADDING
//        highlight: appHighlight
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true

        property int index4: 0
        property int index5: 0

        property int centerIndex: 0

        property variant gridData: [0,1,2,2,3]

        onCurrentIndexChanged: {

            /* Menu has 5 elements, but only 4 icons,
              first and last icons are duplicated
            var tData = [
                        [0,1,2,2,3], // 0 0
                        [0,1,2,3,3], // 1 1
                        [0,1,2,3,0], // 2 2
                        [1,1,2,3,0], // 3 3
                        [1,2,2,3,0], // 0 4
                        [1,2,3,3,0], // 1 0
                        [1,2,3,0,0], // 2 1
                        [1,2,3,0,1], // 3 2
                        [2,2,3,0,1], // 0 3
                        [2,3,3,0,1], // 1 4
                    ]
            */

            var delta = view.currentIndex - centerIndex
            if (delta > 2.5) {
                delta -=5
            } else if (delta < -2.5) {
                delta +=5
            }

            index4 = Consts.incrementMinMaxWrap(index4, delta, 0, 4)
            index5 = Consts.incrementMinMaxWrap(index5, delta, 0, 5)

            var t_DATA = [0,0,0,0,0]
            for (var i=0;i < 5;i++) {

                t_DATA[index5] = index4

                var iDirection = delta/(Math.abs(delta))
                index5 = Consts.incrementMinMaxWrap(index5, 1*iDirection, 0, 5)
                if (i!==2) {
                    index4 = Consts.incrementMinMaxWrap(index4, 1*iDirection, 0, 4)
                }
            }

            gridData = t_DATA

            centerIndex = view.currentIndex
        }

        model: 5
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
