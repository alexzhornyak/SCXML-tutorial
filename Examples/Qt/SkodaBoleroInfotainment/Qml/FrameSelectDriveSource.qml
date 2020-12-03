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

        var t_model = [{
                           text: "RESET TO DEFAULT",
                           eventName: "DriveSource." + driveInput
                       }]

        storage.refresh()
        var volumes = storage.getMountedVolumes()
        for (var vol of volumes) {

            var url = fileUtils.urlFromLocalFile(vol)
            var s_url = url.toString().toLowerCase()

            var value_text = undefined

            for (var drive of storageList) {
                var s_drive_url = drive.urlPath.toString().toLowerCase()
                if (s_url === s_drive_url) {
                    value_text = "[" + drive.ident + "]"
                    break
                }
            }

            t_model.push({
                             text: vol,                             
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
