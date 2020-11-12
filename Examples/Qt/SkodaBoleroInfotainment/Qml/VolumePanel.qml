import QtQuick 2.12
import QtQuick.Controls 2.12
import "AppConstants.js" as AppConsts

Rectangle {
    color: AppConsts.cl_BACKGROUND

    ProgressBar {
        id: progress
        anchors.horizontalCenter: parent.horizontalCenter

        anchors.top: parent.top
        anchors.bottom: parent.bottom

        width: parent.width * 0.75
        from: 0
        to: 1.0
        value: scxmlBolero.getVolume()

        background: Rectangle {
            anchors.verticalCenter: parent.verticalCenter

            height: 12
            color: AppConsts.cl_BACKGROUND
            border.color: AppConsts.cl_ITEM_BORDER
            border.width: 2
            radius: 6
        }

        contentItem: Item {

            Rectangle {
                anchors.left: parent.left
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter

                width: progress.visualPosition * (parent.width - 4)
                height: 6
                radius: 3
                color: AppConsts.cl_SELECTION
            }
        }

    }

    Image {
        anchors.right: progress.left
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15

        fillMode: Image.PreserveAspectFit

        source: "qrc:/Qml/Images/ImgMusic.png"
    }

    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        color: AppConsts.cl_ITEM_BORDER
        border.color: AppConsts.cl_ITEM_BORDER

        height: 3
    }
}
