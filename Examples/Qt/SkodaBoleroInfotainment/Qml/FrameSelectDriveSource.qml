import QtQuick 2.0
import StorageInfo 1.0
import FileUtils 1.0

FrameSettings {

    property string driveInput: selectDriveSourceLoader.driveInput

    caption: qsTr("Select drive source") + " [" + driveInput + "]"

    viewLayout.columns: 1

    encoderHighliterEnabled: true

    repeater.model: getRepeaterModel()

    function getRepeaterModel() {

        var t_model = []

        var s_CD = storageCD.urlPath.toString().toLowerCase()
        var s_SD = storageSD.urlPath.toString().toLowerCase()
        var s_USB = storageUSB.urlPath.toString().toLowerCase()

        var volumes = storage.getMountedVolumes()
        for (var vol of volumes) {

            var url = fileUtils.urlFromLocalFile(vol)
            var s_url = url.toString().toLowerCase()

            var value_text = undefined
            if (s_url === s_CD) {
                value_text = "[CD]"
            } else if (s_url === s_SD) {
                value_text = "[SD]"
            } else if (s_url === s_USB) {
                value_text = "[USB]"
            }

            t_model.push({
                             text: vol,
                             enabled: value_text===undefined,
                             valueText: value_text,
                             eventName: "DriveSource." + driveInput,
                             eventData: url
                         })
        }

        return t_model
    }

    StorageInfo {
        id: storage
    }
}
