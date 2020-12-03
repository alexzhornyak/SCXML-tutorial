import QtQuick 2.0

import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtScxml 5.8
import "AppConstants.js" as AppConsts
import "qrc:/Model/CommonConstants.js" as Consts

import Qt.labs.folderlistmodel 2.12
import QtMultimedia 5.15
import FileUtils 1.0
import MaskedMouseArea 1.0

BoleroBackgroundRender {
    id: frame

    property string caption: ""

    property url currentUrl: ""

    property bool userNavigating: false

    enum SubFolderType {
        Side,
        Collapsed,
        Indexed
    }

    function getPathModel() {
        var s_folder = folderUrl.toString();
        if (s_folder !== "") {

            for (var storage of storageList) {
                var s_drive = storage.urlPath.toString()
                if (s_folder.toLowerCase().indexOf(s_drive.toLowerCase())===0) {
                    /* extract relative path without drive */
                    /* file:///drive/relative/path -> relative/path */
                    s_folder = s_folder.substring(s_drive.length)

                    var parts = s_folder.split("/")
                    parts = parts.filter(el => el!=="")

                    /* 2 folders are shown with numbers */
                    /* [CD]> 1> 2> Folder Caption */

                    /* if there are more than 2 folders */
                    /* middle folders are collapsed and last ones are shown with numbers */
                    /* [CD]> > > > 4> 5> */

                    var t_folder = [
                                {
                                    mode: FrameSelectFilesBase.SubFolderType.Side,
                                    url: s_drive  }
                            ]

                    for (var i=0;i<parts.length;i++) {

                        var i_mode = undefined

                        if (i>=(parts.length-2)) {
                            i_mode = FrameSelectFilesBase.SubFolderType.Indexed
                        } else if (i===parts.length-3) {
                            i_mode = FrameSelectFilesBase.SubFolderType.Collapsed
                        }

                        if (i_mode!==undefined) {
                            // required for caption
                            var s_file_part = parts[i]

                            var t_url = parts.slice(0,i)

                            var s_url = s_drive + t_url.join("/")

                            t_folder.push({ filePart: s_file_part, mode: i_mode, id: i + 1, url: s_url })
                        }
                    }

                    folderCaption = parts.length > 1 ? parts[parts.length-1] : ""
                    return t_folder
                }
            }
        }

        folderCaption = ""
        return []
    }

    function getDriveType() {
        var s_folder = folderUrl.toString()
        if (s_folder !== "") {
            for (var storage of storageList) {
                var s_drive = storage.urlPath.toString()
                if (s_folder.toLowerCase().indexOf(s_drive.toLowerCase())===0) {
                    return storage.ident
                }
            }

            console.error("Can not detect drive type for folder", folderUrl)
        }

        return ""
    }

    function getDriveImage() {
        var s_drive_type = getDriveType()
        if (s_drive_type !== "")
            return "qrc:/Qml/Images/Img" + s_drive_type + "_32.png";

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
        case FrameSelectFilesBase.SubFolderType.Side: return getDriveImage();
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
        var s_url = url.toString().toLowerCase()
        var s_cur_url = currentUrl.toString().toLowerCase()
        return s_url !== "" && s_url === s_cur_url
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
    property alias folderSortField: folderModel.sortField

    FolderListModel {
        id: folderModel

        caseSensitive: false

        folder: folderUrl

        onFolderChanged: highlighter.selectedIndex = -1

        onStatusChanged: if (status === FolderListModel.Ready) highlighter.count = folderModel.count

        function getSelectedEventName(i_index) {
            return isFolder(i_index) ?
                "DirSelected" : "FileSelected"
        }

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

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.FileSelected"]
        onOccurred: {
            if (event.data) {
                currentUrl = event.data
                var path = fileUtils.urlExtractPath(currentUrl)

                if (!frame.userNavigating) {
                    folderUrl = path
                }
            } else {
                console.error("Can not select undefined dir")
            }
        }
    }

    EventConnection {
        stateMachine: scxmlBolero
        events: ["Out.SelectFiles.UserNavigating"]
        onOccurred: {
            frame.userNavigating = event.data ? true : false;
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

            onMovingChanged: scxmlBolero.submitEvent("Inp.App.SelectFiles.Action.Moving", moving ? 1 : 0)
            onFlickingChanged: scxmlBolero.submitEvent("Inp.App.SelectFiles.Action.Flicking", flicking ? 1 : 0)
            onDraggingChanged: scxmlBolero.submitEvent("Inp.App.SelectFiles.Action.Dragging", dragging ? 1 : 0)

            function ensureVisible(item) {
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

            ScrollBar.vertical: ScrollBar {
                id: vertScrollBar
                policy: ScrollBar.AlwaysOn

                onPressedChanged: scxmlBolero.submitEvent("Inp.App.SelectFiles.Action.Scroll", pressed ? 1 : 0)

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

                /* bugfix: */
                /* 'count' - should be changed throught 'folder.status==Ready' */
                /* direct property binding does not work correctly */
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

                        /* item selection has priority */
                        onItemSelectedChanged: if (itemSelected) view.ensureVisible(button)

                        Layout.preferredHeight: frame.itemHeight

                        readonly property bool currentItem: frame.isCurrentItem(fileUrl)
                        onCurrentItemChanged: if (currentItem && !userNavigating) view.ensureVisible(button)

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
