import QtQuick 2.12
import QtScxml 5.8
import ScxmlBolero 1.0
import "../"
import "qrc:/Model/CommonConstants.js" as Consts

FrameSelectFiles {

    folderNameFilters: Consts.t_MEDIA_AVAILABLE_EXTENSIONS
    fileListType: FrameSelectFiles.FileListType.Media
}
