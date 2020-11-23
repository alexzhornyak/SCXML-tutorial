import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "qrc:/Qml"
import "qrc:/Qml/AppConstants.js" as AppConsts

BoleroBackgroundRender {
    id: pane
    width: 600
    height: 360
    clip: true

    readonly property int i_ROW_SPACING: 3

    readonly property int panelHeight: height / 6 - AppConsts.i_DISPLAY_PADDING

    enum WarningCode {
        NoWarnings,
        ScanningMedia,
        NoValidInput,
        NoValidMedia
    }

    function getWarningCodeText(i_code) {
        switch (i_code) {
        case FrameMedia.WarningCode.ScanningMedia: return "Scanning media ..."
        case FrameMedia.WarningCode.NoValidInput: return "No valid input!"
        case FrameMedia.WarningCode.NoValidMedia: return "No valid media!"
        }

        return ""
    }

    MouseArea {
        id: paneMouseArea
        hoverEnabled: true
        anchors.fill: parent
        onHoveredChanged: scxmlBolero.submitEvent("Inp.App.Media.Hovered", paneMouseArea.containsMouse ? 1:0)

        Item {
            id: contentPaddingItem
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: bottomPanel.top
            anchors.leftMargin: AppConsts.i_DISPLAY_PADDING
            anchors.topMargin: AppConsts.i_DISPLAY_PADDING
            anchors.rightMargin: AppConsts.i_DISPLAY_PADDING

            HeaderPanel {
                id: headerPanel

                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
            }

            MediaFunctionKeysPanel {
                id: functionKeys

                anchors.right: parent.right
                anchors.left: parent.left
                anchors.bottom: parent.bottom

                anchors.bottomMargin: 10

                height: pane.panelHeight

                visible: scxmlBolero.audioInputDrives
                enabled: scxmlBolero.mediaPlayerNormal
                opacity: enabled ? 1 : 0.5
            }

            MediaTimeline {
                id: timeline

                anchors.right: parent.right
                anchors.left: parent.left
                anchors.bottom: functionKeys.top
                anchors.top: imageSource.bottom

                visible: scxmlBolero.audioInputDrives
                enabled: scxmlBolero.mediaPlayerNormal
                opacity: enabled ? 1 : 0.5
            }

            MediaImage {
                id: imageSource
                anchors.top: headerPanel.bottom
                anchors.right: parent.right
                width: 160
                height: 160
            }

            Text {
                id: textSource

                clip: true

                anchors.left: parent.left
                anchors.leftMargin: 10

                anchors.right: imageSource.left
                anchors.rightMargin: 10

                anchors.top: imageSource.top
                anchors.bottom: imageSource.bottom

                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                style: Text.Outline
                color: AppConsts.cl_ITEM_TEXT
                font.family: "Tahoma"
                font.pixelSize: 26
                wrapMode: Text.WordWrap

                text: audioPlayer.currentPlayUrlFileName

                visible: scxmlBolero.mediaPlayerNormal
            }

            Item {
                id: warningPanel

                anchors.left: parent.left
                anchors.top: headerPanel.bottom
                anchors.right: imageSource.left
                anchors.bottom: timeline.top

                function getCode() {
                    if (scxmlBolero.audioInputCD_Init ||
                            scxmlBolero.audioInputSD_Init ||
                            scxmlBolero.audioInputUSB_Init)
                        return FrameMedia.WarningCode.ScanningMedia
                    if (scxmlBolero.audioInputCheck)
                        return FrameMedia.WarningCode.NoValidInput
                    if (scxmlBolero.mediaPlayerError)
                        return FrameMedia.WarningCode.NoValidMedia

                    return FrameMedia.WarningCode.NoWarnings
                }

                property int code: getCode()

                BusyIndicator {
                    id: busyIndicator
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    palette.dark: AppConsts.cl_ITEM_BORDER

                    width: 100

                    running: true
                    visible: warningPanel.code === FrameMedia.WarningCode.ScanningMedia
                }

                Text {
                    id: textWarning

                    clip: true

                    anchors.left: busyIndicator.right
                    anchors.leftMargin: 20

                    anchors.right: parent.right
                    anchors.rightMargin: 10

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    style: Text.Outline
                    color: AppConsts.cl_ITEM_TEXT
                    font.family: "Tahoma"
                    font.pixelSize: 26
                    wrapMode: Text.WordWrap

                    text: getWarningCodeText(warningPanel.code)

                    visible: text !== ""
                }
            }

        }

        /* we use this special overlay to prevent affect on whole application */
        Rectangle {

            color: AppConsts.cl_BACKGROUND
            opacity: AppConsts.d_MODAL_OPACITY
            anchors.fill: parent

            visible: scxmlBolero.mediaModal

            MouseArea {
                anchors.fill: parent

                onClicked: scxmlBolero.submitEvent("Inp.App.Media.ModalOverlay.Clicked")
            }
        }

        MediaBottomPanel {
            id: bottomPanel
            height: pane.panelHeight
            visible: true
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: AppConsts.i_DISPLAY_PADDING
            anchors.leftMargin: AppConsts.i_DISPLAY_PADDING
            anchors.rightMargin: AppConsts.i_DISPLAY_PADDING
        }
    }
}

