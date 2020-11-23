import QtQuick 2.0

import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtScxml 5.8
import "AppConstants.js" as AppConsts
import "qrc:/Model/CommonConstants.js" as Consts

import Qt.labs.folderlistmodel 2.12
import QtMultimedia 5.15
import MaskedMouseArea 1.0

BoleroBackgroundRender {
    id: frame

    property string caption: ""

    enum DriveType {
        Unknown,
        CD,
        SD,
        USB
    }

    enum SubFolderType {
        Side,
        Collapsed,
        Indexed
    }

    function getPathModel() {
        /* URL is expected in format 'file:///c:/' */

        var sFolder = folderUrl.toString()

        sFolder = decodeURIComponent(sFolder.replace(/^(file:\/{2,3})/,""))

        var parts = sFolder.split("/")
        parts = parts.filter(function(el){
            return el!==""
        })

        var t_folder = [
                    {
                        mode: FrameSelectFilesBase.SubFolderType.Side,
                        url: parts.length > 0 ? ("file:///" + parts[0]) : undefined  }
                ]

        for (var i=0;i<parts.length-1;i++) {

            var i_mode = undefined

            if (i>=(parts.length-3)) {
                i_mode = FrameSelectFilesBase.SubFolderType.Indexed
            } else if (i===parts.length-4) {
                i_mode = FrameSelectFilesBase.SubFolderType.Collapsed
            }

            if (i_mode!==undefined) {
                // required for caption
                var s_file_part = parts[i]

                var s_url = ""

                var t_url = parts
                t_url = t_url.slice(0,i+1)
                s_url += "file:///" + t_url.join("/")

                t_folder.push({ filePart: s_file_part, mode: i_mode, id: i + 1, url: s_url })
            }
        }

        folderCaption = parts.length > 1 ? parts[parts.length-1] : ""

        return t_folder
    }

    function getDriveType() {
        if (folderUrl.toString() !== "") {
            if (storageCD.hasPath(folderUrl)) {
                return FrameSelectFilesBase.DriveType.CD
            } else if (storageSD.hasPath(folderUrl)) {
                return FrameSelectFilesBase.DriveType.SD
            } else if (storageUSB.hasPath(folderUrl)) {
                return FrameSelectFilesBase.DriveType.USB
            }

            console.error("Can not detect drive type for folder", folderUrl)
        }

        return FrameSelectFilesBase.DriveType.Unknown
    }

    function getDriveImage() {
        var i_drive_type = getDriveType()
        switch (i_drive_type) {
        case FrameSelectFilesBase.DriveType.CD: return "Images/ImgCD_32.png";
        case FrameSelectFilesBase.DriveType.SD: return "Images/ImgSD_32.png";
        case FrameSelectFilesBase.DriveType.USB: return "Images/ImgUSB_32.png";
        }

        return ""
    }

    function getFolderImageSource(i_mode) {
        switch(i_mode) {
        case FrameSelectFilesBase.SubFolderType.Side: return "Images/ImgBtnTriangleSide.png";
        case FrameSelectFilesBase.SubFolderType.Indexed: return "Images/ImgBtnTriangleIndexed.png";
        case FrameSelectFilesBase.SubFolderType.Collapsed: return "Images/ImgBtnTriangleCollapsed.png";
        }

        console.error("Can not get folder image for mode", i_mode)
        return "" // mustn't occur
    }

    function getFolderSubImageSource(i_mode) {
        switch(i_mode) {
        case FrameSelectFilesBase.SubFolderType.Side: return getDriveImage(getDriveType());
        case FrameSelectFilesBase.SubFolderType.Indexed: return "Images/ImgFolderNumber.png";
        case FrameSelectFilesBase.SubFolderType.Collapsed: return "";
        }

        console.error("Can not get folder subimage for mode", i_mode)
        return "" // mustn't occur
    }

    function onImageFolderPressed(i_mode, url) {
        switch (i_mode) {
        case FrameSelectFilesBase.SubFolderType.Side:
        case FrameSelectFilesBase.SubFolderType.Indexed:
            scxmlBolero.submitBtnSetupEvent("DirSelected", url)
            break
        }
    }

    function isCurrentItem(url) {
        return false
    }

    function getItemIcon(url, is_current_item) {
        return ""
    }

    readonly property real headerHeight: height/6 - AppConsts.i_DISPLAY_PADDING

    property int itemHeight: 65
    property int itemIconWidth: 80
    property int itemIconFillMode: Image.PreserveAspectFit

    property alias viewLayout: viewLayout
    property alias header: header
    property alias itemsList: view
    property alias functionsPanel: functionsPanel

    property url folderUrl: ""
    property alias folderNameFilters: folderModel.nameFilters
    property alias folderCaption: folderText.text

    FolderListModel {
        id: folderModel

        caseSensitive: false
        sortField: FolderListModel.Type

        folder: folderUrl

        function getSelectedEventName(i_index) {
            return isFolder(i_index) ?
                "DirSelected" : "FileSelected"
        }

    }

    onFolderUrlChanged: {
        highlighter.selectedIndex = -1
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.DirSelected"]
        onOccurred: {            
            if (event.data) {
                folderUrl = event.data
            } else {
                console.error("Can not select undefined dir")
            }
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

                    model: frame.getPathModel()

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

                        width: sourceSize.width

                        x: getX()

                        source: frame.getFolderImageSource(modelData.mode)

                        fillMode: Image.Pad

                        Image {
                            id: subFolderImage
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset:
                                modelData.mode === FrameSelectFilesBase.SubFolderType.Side ? -5 : 0

                            fillMode: Image.Pad

                            source: frame.getFolderSubImageSource(modelData.mode)

                            Text {
                                id: textFolderIndex
                                visible: modelData.mode === FrameSelectFilesBase.SubFolderType.Indexed
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

                            onPressed: frame.onImageFolderPressed(modelData.mode, modelData.url)
                        }
                    }
                }
            }

            Text {
                id: folderText
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

        /* additional function content */
        Item {
            id: functionsPanel

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: header.bottom

            height: 0
        }

        Flickable {
            id: view

            visible: true

            clip: true

            anchors.top: functionsPanel.bottom
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
                enabled: frame.enabled
                count: folderModel.count
                eventName: selectedIndex!==-1 ? folderModel.getSelectedEventName(selectedIndex) : ""
                eventData: selectedIndex!==-1 ? folderModel.get(selectedIndex, "fileUrl") : undefined
            }

            function ensureVisible(item) {
                if (moving || dragging)
                    return;

                var ypos = item.mapToItem(contentItem, 0, 0).y
                var ext = item.height + ypos
                if ( ypos < contentY // begins before
                        || ypos > contentY + height // begins after
                        || ext < contentY // ends before
                        || ext > contentY + height) { // ends after
                    // don't exceed bounds
                    var i_ensure_bottom = Math.max(0, Math.min(ypos - height + item.height, contentHeight - height))
                    contentY = i_ensure_bottom
                }
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

                        onItemSelectedChanged: if (itemSelected) view.ensureVisible(button)

                        Layout.preferredHeight: frame.itemHeight

                        readonly property bool currentItem: frame.isCurrentItem(fileUrl)
                        onCurrentItemChanged: if (currentItem) view.ensureVisible(button)

                        contentItem: Item {
                            anchors.fill: button

                            Image {
                                id: imgIcon

                                width: frame.itemIconWidth

                                anchors.left: parent.left
                                anchors.leftMargin: 15
                                anchors.top: parent.top
                                anchors.topMargin: 3
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 3

                                fillMode: fileIsDir ? Image.Pad : frame.itemIconFillMode
                                source: fileIsDir ? "Images/ImgFolder.png" :  frame.getItemIcon(fileUrl, button.currentItem)
                            }

                            Text {
                                id: textCaption
                                anchors.left: imgIcon.right
                                anchors.leftMargin: 15
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
