import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../AppConstants.js" as AppConsts
import "../"

BoleroBackgroundRender {
    id: frame

    enum ManageGroupType {
            Presets,
            Logos
    }

    readonly property real headerHeight: height/6 - AppConsts.i_DISPLAY_PADDING    
    required property int manageGroupType
    property alias contentVisible: groupContent.visible

    Item {
        id: layerItem
        anchors.fill: parent
        anchors.margins: AppConsts.i_DISPLAY_PADDING

        SetupHeader {
            id: header

            function getHeaderCaption() {
                switch(frame.manageGroupType) {
                case FrameRadioManageGroup.ManageGroupType.Presets:
                    return qsTr(scxmlBolero.settings.BandType + " preset list")
                case FrameRadioManageGroup.ManageGroupType.Logos:
                    return qsTr("Manage st.logos")
                }
                return ""
            }

            caption: getHeaderCaption()
            height: frame.headerHeight

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            DeleteAllButton {

                enabled: isDeleteAllEnabled()
                opacity: enabled ? 1.0 : 0.5

                anchors.right: header.anchorBackLeft
                anchors.rightMargin: 4
                anchors.top: parent.top
                anchors.bottom: parent.bottom                

                confirmationText: getDeleteAllConfirmationText()

                function getDeleteAllConfirmationText() {
                    switch (frame.manageGroupType) {
                    case FrameRadioManageGroup.ManageGroupType.Presets:
                        return "Delete all stored stations -\n" +
                                "are you sure?"
                    case FrameRadioManageGroup.ManageGroupType.Logos:
                        return "Delete all stored logos -\n" +
                                "are you sure?"
                    }
                    return ""
                }

                function isDeleteAllEnabled() {
                    switch (frame.manageGroupType) {
                    case FrameRadioManageGroup.ManageGroupType.Presets:
                        return !scxmlBolero.areRadioPresetsEmpty()
                    case FrameRadioManageGroup.ManageGroupType.Logos:
                        return !scxmlBolero.areRadioLogosEmpty()
                    }
                    return false
                }
            }
        }

        Item {
            id: groupContent
            anchors.fill: parent

            SwipeView {
                id: swipeStations
                clip: true
                padding: 0
                currentIndex:  0
                hoverEnabled: true

                height: frame.height / 3 - AppConsts.i_DISPLAY_PADDING
                width: layerItem.availableWidth

                anchors.left: parent.left
                anchors.right: parent.right

                anchors.verticalCenter: parent.verticalCenter

                Repeater {
                    id: repeaterPresets
                    model: 3

                    anchors.fill: parent

                    delegate: RowLayout {
                        id: stationsRow
                        spacing: 5

                        readonly property int groupIndex: index

                        Repeater {
                            id: repeaterStations
                            model: 5

                            delegate: RadioStationBase {
                                id: station
                                stationIndex: (stationsRow.groupIndex * 5) + index

                                onReleased: {
                                    if (imgDelete.visible) {

                                        switch (frame.manageGroupType) {
                                        case FrameRadioManageGroup.ManageGroupType.Presets:
                                            scxmlBolero.submitEvent("Inp.App.Radio.DeleteElement", {
                                                                        confirmationText: "Do you really want to\n" +
                                                                                          "delete the stored station?",
                                                                        confirmationModel: [
                                                                            { text: "Cancel", keyCentered: true },
                                                                            { text: "Delete", eventData: stationIndex, keyCentered: true }]
                                                                    })
                                            break;
                                        case FrameRadioManageGroup.ManageGroupType.Logos:
                                            scxmlBolero.submitEvent("Inp.App.Radio.DeleteElement", {
                                                                        confirmationText: "Do you really want to\n" +
                                                                                          "delete the stored logo?",
                                                                        confirmationModel: [
                                                                            { text: "Cancel", keyCentered: true },
                                                                            { text: "Delete", eventData: stationIndex, keyCentered: true }]

                                                                    })
                                            break;
                                        }


                                    } else {
                                        if (scxmlBolero.getRadioFreq(stationIndex)!==0) {
                                            scxmlBolero.submitEvent("Inp.App.Radio.ManageElement", stationIndex);
                                        }
                                    }
                                }

                                Image {
                                    id: imgDelete
                                    visible: isDeleteVisible()

                                    anchors.top: parent.top
                                    anchors.right: parent.right
                                    anchors.topMargin: 6
                                    anchors.rightMargin: 3

                                    source: "../Images/ImgDelete.png"

                                    fillMode: Image.Pad

                                    function isDeleteVisible() {
                                        switch (frame.manageGroupType) {
                                        case FrameRadioManageGroup.ManageGroupType.Presets:
                                            var dFreq = scxmlBolero.getRadioFreq(station.stationIndex)
                                            return dFreq!==0
                                        case FrameRadioManageGroup.ManageGroupType.Logos:
                                            var sLogo = scxmlBolero.getRadioLogosSource(station.stationIndex)
                                            return sLogo!==""
                                        }
                                        return false
                                    }
                                }
                            }
                        }
                    }
                }
            }

            PageIndicator {
                id: pageIndicator
                count: 3
                height: frame.height / 6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: swipeStations.bottom
                currentIndex: swipeStations.currentIndex

                delegate: Rectangle {
                    y: parent.height / 2
                    implicitWidth: layerItem.width / 5
                    implicitHeight: 6

                    border.width: 2
                    border.color: pageIndicator.currentIndex
                                  === index ? AppConsts.cl_SELECTION : AppConsts.cl_BACKGROUND_LIGHT

                    color: AppConsts.cl_BACKGROUND_LIGHT

                    MouseArea {
                        anchors.fill: parent
                        /* in real device area is greater than indicator rect */
                        anchors.topMargin: -20
                        anchors.bottomMargin: -20
                        onClicked: swipeStations.currentIndex = index
                    }
                }
            }
        }
    }
}
