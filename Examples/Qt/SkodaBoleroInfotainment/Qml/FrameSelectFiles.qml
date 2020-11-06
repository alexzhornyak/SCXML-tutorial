import QtQuick 2.0

import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtScxml 5.8
import "AppConstants.js" as AppConsts
import "../Model/CommonConstants.js" as Consts

import Qt.labs.folderlistmodel 2.12
import MaskedMouseArea 1.0

BoleroBackgroundRender {
    id: frame

    property string caption: ""

    readonly property real headerHeight: height/6 - AppConsts.i_DISPLAY_PADDING
    property alias viewLayout: viewLayout
    property alias folderRoot: folderModel.folder

    enum SubFolderType {
        Side,
        Collapsed,
        Indexed
    }

    enum DriveType {
        Unknown,
        CD,
        SD,
        USB
    }

    FolderListModel {
        id: folderModel
        nameFilters: ["*.png"]

        property int driveType: FrameSelectFiles.DriveType.Unknown

        function getSelectedEventName(i_index) {
            return isFolder(i_index) ?
                "DirSelected" : "FileSelected"
        }

        function getPathModel() {

            /* URL is expected in format 'file:///c:/' */

            var sFolder = folder.toString()

            sFolder = decodeURIComponent(sFolder.replace(/^(file:\/{2,3})/,""))

            var parts = sFolder.split("/")
            parts = parts.filter(function(el){
                return el!==""
            })

            var t_folder = [
                        { mode: FrameSelectFiles.SubFolderType.Side }
                    ]

            for (var i=0;i<parts.length-1;i++) {

                var i_mode = undefined

                if (i>=(parts.length-3)) {
                    i_mode = FrameSelectFiles.SubFolderType.Indexed
                } else if (i===parts.length-4) {
                    i_mode = FrameSelectFiles.SubFolderType.Collapsed
                }

                if (i_mode!==undefined) {
                    // required for caption
                    var s_file_part = parts[i]

                    var s_url = ""

                    var t_url = parts
                    t_url = t_url.slice(0,i+1)
                    s_url += "file:///" + t_url.join("/")

                    t_folder.push({ filePart: s_file_part, mode: i_mode, id: i + 1, url: s_url})
                }
            }

            folderCaption.text = parts.length > 1 ? parts[parts.length-1] : ""

            return t_folder
        }

        onFolderChanged: {            
            folderCaption.text = "Loading..."

            foldersRepeater.model = getPathModel()

            highlighter.selectedIndex = -1
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.DirSelected"]
        onOccurred: {            
            var s_folder_url = event.data
            if (Consts.strStartsText(s_folder_url, scxmlBolero.driveCD)) {
                folderModel.driveType = FrameSelectFiles.DriveType.CD
            } else if (Consts.strStartsText(s_folder_url, scxmlBolero.driveSD)) {
                folderModel.driveType = FrameSelectFiles.DriveType.SD
            } else if (Consts.strStartsText(s_folder_url, scxmlBolero.driveUSB)) {
                folderModel.driveType = FrameSelectFiles.DriveType.USB
            } else {
                console.error("Drive type [",event.data,"] is not defined!")
            }

            folderModel.folder = s_folder_url
        }
    }

    Item {
        id: layerItem
        anchors.fill: parent
        anchors.margins: AppConsts.i_DISPLAY_PADDING

        Item {
            id: header

            height: frame.headerHeight

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            Item {
                id: foldersLayout

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                width: childrenRect.width

                Repeater {
                    id: foldersRepeater

                    /* do not bind 'model' here because it assign 'folder' twice on creation ! */

                    delegate: Image {
                        id: imageFolder

                        function getX() {
                            var dX = 0
                            for (var i=0;i<index;i++) {
                                var objImage = foldersRepeater.itemAt(i)
                                if (objImage) {
                                    var dOverlappedOffset = 12
                                    dX+=objImage.width - dOverlappedOffset
                                }
                            }
                            return dX
                        }

                        function getImageSource() {
                            switch(modelData.mode) {
                            case FrameSelectFiles.SubFolderType.Side: return "Images/ImgBtnTriangleSide.png";
                            case FrameSelectFiles.SubFolderType.Indexed: return "Images/ImgBtnTriangleIndexed.png";
                            case FrameSelectFiles.SubFolderType.Collapsed: return "Images/ImgBtnTriangleCollapsed.png";
                            }

                            return undefined // mustn't occur
                        }

                        function getDriveImage() {
                            switch (folderModel.driveType) {
                            case FrameSelectFiles.DriveType.CD: return "Images/ImgCD_32.png";
                            case FrameSelectFiles.DriveType.SD: return "Images/ImgSD_32.png";
                            case FrameSelectFiles.DriveType.USB: return "Images/ImgUSB_32.png";
                            }

                            return undefined // mustn't occur
                        }

                        function getSubImageSource() {
                            switch(modelData.mode) {
                            case FrameSelectFiles.SubFolderType.Side: return getDriveImage();
                            case FrameSelectFiles.SubFolderType.Indexed: return "Images/ImgFolderNumber.png";
                            case FrameSelectFiles.SubFolderType.Collapsed: return "";
                            }

                            return undefined // mustn't occur
                        }

                        width: sourceSize.width

                        x: getX()

                        source: getImageSource()

                        fillMode: Image.Pad

                        Image {
                            id: subFolderImage
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset:
                                modelData.mode === FrameSelectFiles.SubFolderType.Side ? -5 : 0

                            fillMode: Image.Pad

                            source: getSubImageSource()

                            Text {
                                id: textFolderIndex
                                visible: modelData.mode === FrameSelectFiles.SubFolderType.Indexed
                                anchors.right: parent.right
                                anchors.rightMargin: 6
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: -6
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignBottom
                                style: Text.Outline
                                color: AppConsts.cl_ITEM_TEXT
                                font.family: "Tahoma"
                                font.pixelSize: 12

                                text: modelData.id !== undefined ? modelData.id : ""
                            }
                        }

                        MaskedMouseArea {
                            id: folderPressArea
                            anchors.fill: parent
                            alphaThreshold: 0.1
                            maskSource: imageFolder.source

                            onPressed: {
                                if (modelData.mode===FrameSelectFiles.SubFolderType.Indexed) {
                                    scxmlBolero.submitBtnSetupEvent("DirSelected",
                                                                          modelData.url)
                                }
                            }
                        }
                    }
                }
            }

            Text {
                id: folderCaption
                anchors.left: foldersLayout.right
                anchors.leftMargin: 10
                anchors.right: btnBack.left
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                style: Text.Outline
                color: AppConsts.cl_ITEM_TEXT
                font.family: "Tahoma"
                font.pixelSize: 20
                clip: true
            }

            SelectBackButton {
                id: btnBack
                anchors.right: header.right
                anchors.top: header.top
                anchors.bottom: header.bottom
            }
        }

        Flickable {
            id: view

            visible: true

            clip: true

            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.topMargin: AppConsts.i_SETTINGS_GRID_SPACING

            contentHeight: viewLayout.height

            interactive: viewLayout.height > view.height

            boundsBehavior: Flickable.StopAtBounds

            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AlwaysOn

                contentItem: Rectangle {
                    visible: view.interactive
                    implicitWidth: 8
                    radius: width / 2
                    border.color: AppConsts.cl_SELECTION
                    border.width: 2
                    color: AppConsts.cl_BACKGROUND
                }

                background: Rectangle {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 1

                    width: 3
                    radius: 2

                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: AppConsts.cl_BACKGROUND_LIGHT
                        }

                        GradientStop {
                            position: 0.4
                            color: AppConsts.cl_ITEM_BORDER
                        }

                        GradientStop {
                            position: 0.6
                            color: AppConsts.cl_ITEM_BORDER
                        }

                        GradientStop {
                            position: 1
                            color: AppConsts.cl_BACKGROUND_LIGHT
                        }
                    }
                }
            }



            EncoderHighlighter {
                id: highlighter
                enabled: true
                count: folderModel.count
                eventName: selectedIndex!==-1 ? folderModel.getSelectedEventName(selectedIndex) : ""
                eventData: selectedIndex!==-1 ? folderModel.get(selectedIndex, "fileUrl") : undefined
            }

            GridLayout {
                id: viewLayout
                columnSpacing: AppConsts.i_SETTINGS_GRID_SPACING
                rowSpacing: AppConsts.i_SETTINGS_GRID_SPACING

                columns: 1

                width: view.width - AppConsts.i_SETTINGS_BUTTON_OFFSET

                Repeater {
                    id: repeaterSettings

                    model: folderModel

                    delegate: SelectButton {
                        id: button
                        itemSelected: index === highlighter.selectedIndex || pressed

                        Layout.preferredHeight: 65

                        contentItem: Item {
                            anchors.fill: button

                            Image {
                                id: imgIcon
                                width: 80

                                anchors.left: parent.left
                                anchors.leftMargin: 15
                                anchors.top: parent.top
                                anchors.topMargin: 3
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 3

                                fillMode: fileIsDir ? Image.Pad : Image.PreserveAspectFit
                                source: fileIsDir ? "Images/ImgFolder.png" : fileUrl
                            }

                            Text {
                                id: textCaption
                                anchors.left: imgIcon.right
                                anchors.leftMargin: 20
                                anchors.right: parent.right
                                anchors.rightMargin: 15
                                anchors.verticalCenter: parent.verticalCenter
                                verticalAlignment: Text.AlignVCenter
                                style: Text.Outline
                                color: AppConsts.cl_ITEM_TEXT
                                font.family: "Tahoma"
                                font.pixelSize: 20
                                clip: true

                                text: fileName
                            }

                        }

                        onPressed: {
                            highlighter.selectedIndex = -1
                        }

                        onReleased: {                            
                            scxmlBolero.submitBtnSetupEvent(
                                        folderModel.getSelectedEventName(index),
                                        fileUrl)
                        }
                    }
                }
            }

        }
    }
}
