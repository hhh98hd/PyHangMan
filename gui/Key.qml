import QtQuick 2.0

Item {
    id: itemRoot
    width: 50
    height: 50

    property alias letter: itemText.text
    signal keyPressed(key: string)

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: "#abdbe3"

        Text {
            id: itemText
            anchors.centerIn: parent
            font.bold: true
            font.pixelSize: 16
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                parent.color = "#0967a4";
                itemText.color = "white"
            }

            onExited: {
                parent.color = "#abdbe3";
                itemText.color = "black"
            }

            onPressed: {
                parent.color = "#e28743";
            }

            onReleased: {
                parent.color = "#0967a4";
            }

            onClicked: {
                itemRoot.keyPressed(itemText.text);
            }
        }
    }

    Component.onCompleted: {
        keyPressed.connect(root.onKeyPressed);
    }
}
