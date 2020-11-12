import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/Qml/AppConstants.js" as AppConsts
import "../"

Item {

    // Connections to change the position of status slider according to the position of the audio.
    Connections {
        target: audioPlayer
        function onCurrentPlayPosChanged() {
            if (!timeSlider.pressed) {
                timeSlider.value = audioPlayer.currentPlayPos
            }
        }
    }

    Slider {
        id: timeSlider

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        width: parent.width * 0.75

        from: 0
        to: audioPlayer.currentPlayDuration
        live: true

        onMoved: {
            audioPlayer.currentAudio.seek(timeSlider.valueAt(timeSlider.position))
        }

        background: Rectangle {
            x: timeSlider.leftPadding
            y: timeSlider.topPadding + timeSlider.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 4
            width: timeSlider.availableWidth
            height: implicitHeight
            radius: 2
            color: AppConsts.cl_BACKGROUND_LIGHT

            Rectangle {
                width: timeSlider.visualPosition * parent.width
                height: parent.height
                color: AppConsts.cl_SELECTION
                radius: 2
            }
        }

        handle: null
    }

    function msToTime(s) {
      var ms = s % 1000;
      s = (s - ms) / 1000;
      var secs = s % 60;
      s = (s - secs) / 60;
      var mins = s % 60;
      var hrs = (s - mins) / 60;

      var s_hrs = hrs!==0 ? (hrs + ':') : '';
      var s_mins = (mins < 10 ? ('0' + mins) : mins) + ':'
      var s_secs = secs < 10 ? ('0' + secs) : secs

      return s_hrs + s_mins + s_secs;
    }

    Text {
        id: textPosition

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        anchors.right: timeSlider.left
        anchors.rightMargin: 5

        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        style: Text.Outline
        color: AppConsts.cl_ITEM_TEXT
        font.family: "Tahoma"
        font.pixelSize: 16

        text: audioPlayer.currentPlayPos == undefined ? "0:00" : msToTime(audioPlayer.currentPlayPos)
    }

    Text {
        id: textElapsed

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        anchors.left: timeSlider.right
        anchors.leftMargin: 5

        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        style: Text.Outline
        color: AppConsts.cl_ITEM_TEXT
        font.family: "Tahoma"
        font.pixelSize: 16

        function getElapsed() {
            var i_elapsed = 0

            if (audioPlayer.currentPlayDuration) {
                var i_position = audioPlayer.currentPlayPos ? audioPlayer.currentPlayPos : 0

                i_elapsed = audioPlayer.currentPlayDuration - i_position
            }

            return i_elapsed
        }

        text: (audioPlayer.currentPlayPos ? '-' : '') + msToTime(getElapsed())
    }
}
