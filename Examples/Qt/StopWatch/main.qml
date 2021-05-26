import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import ScxmlStopWatch 1.0
import QtScxml 5.8

import "qrc:/../Include"

Window {
    id: window
    width: 320    
    height: 480
    visible: true
    title: qsTr("Stop Watch")

    function pad(number) {
         if (number < 10) {
           return '0' + number;
         }
         return number;     
    }

    ScxmlStopWatch {
        id: machine

        running: false

        Component.onCompleted: {
            /* DataModel values may be changed here */
            machine.initialValues = {
                "i_UPDATE_DELAY_MS" : 100 /* you may change interval here and
                                             it will be applied to state machine  */
            }

            machine.running = true
        }
    }

    EventConnection {
        stateMachine: machine
        events: ["out.display"]
        onOccurred: {

            textTime.text = event.data.ElapsedMS
            textLap.text = event.data.LapMS

            /* Simple Timer Mode */
            var lapCount = event.data.LapCount
            if (lapCount===0) {
                if (listView.model.count)
                    listView.model.clear()
            }
            /* User Pressed Lap Button */
            else {
                /* New Lap */
                if ((listView.count-1)!==lapCount) {

                    /* If this is the first press of 'Lap' button */
                    /* display previous lap */
                    if (lapCount===1) {
                        listView.model.insert(0, { lapIndex: 1,
                                                  startTime: "00:00.000",
                                                  endTime: event.data.ElapsedMS })
                    }

                    /* current lap */
                    listView.model.insert(0, { lapIndex: lapCount + 1,
                                              startTime: event.data.ElapsedMS,
                                              endTime: "00:00.000" })

                    /* scroll to top item */
                    listView.currentIndex = 0
                }
                /* Updating Current Lap Values */
                else if (listView.count>1) {
                    listView.model.setProperty(0, "endTime", event.data.LapMS)
                }
            }
        }
    }

    Loader {    /* OPTIONAL SVG MONITOR */
        id: svgMonitorLoader

        Component {
            id: svgMonitorComponent

            ScxmlSvgMonitorWindow {
                id: svgMonitorWindow

                visible: true

                x: svgMonitorLoader.x

                width: 620
                height: 960

                svgMonitor.svgUrl: "qrc:/StopWatch.svg"

                Component.onCompleted: {
                    svgMonitor.scxmlStateMachine = machine
                }

                onVisibleChanged: if (!visible) { svgMonitorLoader.sourceComponent = null }
            }
        }
    }

    Item {
        id: timeItem

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: listView.visible ? listView.top : bottomPanel.top

        CheckBox {    /* OPTIONAL SVG MONITOR */
            id: checkMonitor

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 10

            text: qsTr("Monitor")

            checkable: false
            checked: svgMonitorLoader.status === Loader.Ready

            onClicked: {

                var notmonitored = svgMonitorLoader.sourceComponent === null
                if (notmonitored) {
                    svgMonitorLoader.x = window.x + window.width + 20
                }

                svgMonitorLoader.sourceComponent = notmonitored ?
                       svgMonitorComponent : null
            }
        }

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
                    Layout.preferredWidth: row1.width * 0.2
                    Layout.fillHeight: true
                }

                Text {
                    text: startTime

                    Layout.preferredWidth: row1.width * 0.4
                    Layout.fillHeight: true
                }

                Text {
                    text: endTime

                    Layout.preferredWidth: row1.width * 0.4
                    Layout.fillHeight: true
                }
            }
    }
}

