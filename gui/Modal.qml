import QtQuick 2.0

Item {
    id: modal_root

    property alias modalText: model_text.text

    Rectangle {
        color: "black"
        anchors.fill: parent
        opacity: 0.8
    }

    Rectangle {
        id: modal_rect
        width: 0.9 * parent.width
        height: 0.4 * parent.height
        anchors.centerIn: parent
        color: "white"
        radius: 8

        Text {
            id: model_text
            width: parent.width
            anchors.fill: parent
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            text: qsTr("")
            font.pixelSize: 26
            wrapMode: Text.WordWrap

            horizontalAlignment: Text.AlignHCenter
        }

        Key {
            id: modal_btn_ok
            width: parent.width * 0.4
            letter: "OK"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: modal_rect.bottom
            anchors.topMargin: 5
            anchors.bottomMargin: 10

            MouseArea {
                id: modal_btn_ok_mouse_area
                anchors.fill: parent
                onPressed: {
                    parent.color = "#e28743";
                }

                onReleased: {
                    parent.color = "#0967a4";
                }

                onClicked: {
                    modal_root.visible = false;
                }
            }
        }
    }
}
