import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtScxml 5.8
import "AppConstants.js" as AppConsts
import "qrc:/Model/CommonConstants.js" as Consts

BoleroBackgroundRender {
    id: frameMenu
    clip: true

    readonly property var t_MODEL: [
        { event: "Radio", url: "Images/ImgMenuRadio.png"},
        { event: "Media", url: "Images/ImgMenuMedia.png"},
        { event: "Setup", url: "Images/ImgMenuSetup.png"},
        { event: "Car", url: "Images/ImgMenuVehicle.png"}]

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

                source: frameMenu.t_MODEL[view.gridData[parent.index]].url
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    /* if was selected, then apply immediately,
                      otherwise wait 1 sec and then apply */

                    var wasSelected = view.currentIndex === parent.index
                    view.currentIndex = parent.index

                    scxmlBolero.submitEvent("Inp.App.Menu", {
                        display: frameMenu.t_MODEL[view.gridData[view.currentIndex]].event,
                        selected: wasSelected
                    })
                }
            }
        }
    }

    PathView {
        id: view
        anchors.fill: parent
        anchors.margins: AppConsts.i_DISPLAY_PADDING
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true

        property int index4: 0
        property int index5: 0

        property int wasIndex: 0

        property variant gridData: [0,1,2,2,3]

        Component.onCompleted: {
            if (scxmlBolero.audioModeMedia)
               currentIndex = 1
        }

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

            var delta = view.currentIndex - wasIndex
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

            wasIndex = view.currentIndex
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

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Inp.Rotate.Select"]
        onOccurred: {

            var dDelta = parseFloat(event.data)

            view.currentIndex =
                    Consts.incrementMinMaxWrap(
                        view.currentIndex,
                        dDelta>0 ? 1 : (dDelta<0 ? -1 : 0), 0, view.model)

        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Inp.Enc.Select"]
        onOccurred: {
                // encoder pressed
                if (event.data===1) {
                    scxmlBolero.submitEvent("Inp.App.Menu", {
                        display: frameMenu.t_MODEL[view.gridData[view.currentIndex]].event,
                        selected: true
                    })
                }

        }
    }
}
