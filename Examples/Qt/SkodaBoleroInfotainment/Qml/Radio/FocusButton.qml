import QtQuick 2.8
import ScxmlBolero 1.0

FocusButtonForm {

    Behavior on verticalFooterOffset {
        NumberAnimation { duration: 500 }
    }

    Behavior on verticalImageOffset {
        NumberAnimation { duration: 500 }
    }
}
