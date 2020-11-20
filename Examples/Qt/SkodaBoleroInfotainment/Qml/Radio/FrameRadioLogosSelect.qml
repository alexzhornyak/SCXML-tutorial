import QtQuick 2.12
import "qrc:/Qml"
import "qrc:/Model/CommonConstants.js" as Consts

FrameSelectFilesBase {
    id: frame

    folderNameFilters: Consts.t_IMAGE_AVAILABLE_EXTENSIONS

    folderUrl: radioSelectLogosLoader.drivePath

    function getItemIcon(url, is_current_item) {
        return url
    }

}
