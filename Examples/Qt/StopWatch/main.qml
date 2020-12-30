import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import ScxmlStopWatch 1.0
import QtScxml 5.8

Window {
    id: window
    width: 320
    visible: true
    height: 480
    title: qsTr("Stop Watch")

    function pad(number) {
         if (number < 10) {
           return '0' + number;
         }
         return number;
    }

    ScxmlStopWatch {
        id: machine
        running: true
    }

    EventConnection {
        stateMachine: machine
        events: ["out.display"]
        onOccurred: {

            textTime.text = event.data.ElapsedMS
            textLap.text = event.data.LapMS

            var lapCount = event.data.LapCount
            if (lapCount===0) {
                listView.model.clear()
            } else {
                if (listView.count!==lapCount) {
                    listView.model.insert(0, { lapIndex: lapCount, startTime: event.data.ElapsedMS, endTime: event.data.LapMS })
                    listView.currentIndex = 0
                } else if (listView.count>0) {
                    listView.model.setProperty(0, "endTime", event.data.LapMS)
                }
            }
        }
    }

    Item {
        id: timeItem

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: listView.visible ? listView.top : bottomPanel.top

        Text {
            id: textTime

            anchors.fill: parent

            text: "00:00"
            font.pixelSize: 22
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: textLap

            anchors.fill: parent
            anchors.topMargin: 22 + 12 + 4

            visible: listView.visible

            text: "00:00"
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }


    RowLayout {
        id: bottomPanel

        anchors.left: parent.left
        anchors.margins: 5
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        height: 40

        Button {            
            text: machine.ready ? qsTr("Start") : machine.active ? qsTr("Pause") : qsTr("Resume")

            palette.buttonText: machine.ready ? "black" : machine.active ? "red" : "green"

            Layout.fillWidth: true
            Layout.fillHeight: true

            onPressed: machine.submitEvent("button.1")
        }

        Button {            
            text: machine.active ? qsTr("Lap") : qsTr("Reset")

            palette.buttonText: "blue"

            Layout.fillWidth: true
            Layout.fillHeight: true

            onPressed: machine.submitEvent("button.2")

            visible: !machine.ready
        }

    }

    ListView {
        id: listView
        anchors.top: parent.top
        anchors.topMargin: parent.height / 3
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottomMargin: 20
        anchors.bottom: bottomPanel.top

        visible: count !== 0

        ScrollBar.vertical: ScrollBar {
            active: true
        }

        model: ListModel {            
        }
        delegate:
            RowLayout {
                id: row1
                x: 20
                width: listView.width - 20
                height: 30

                spacing: 10

                Text {
                    text: pad(lapIndex)

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                Text {
                    text: startTime

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                Text {
                    text: endTime

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
    }
}

