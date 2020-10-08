import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../"
import "../AppConstants.js" as AppConsts

BoleroBackgroundRender {
    id: frameMedia
    clip: true

    Text {
        id: tempText
        anchors.centerIn: parent
        color: "white"
        text: "Vehicle in progress..."
        font.family: "Tahoma"
        font.pixelSize: 26
    }
}
