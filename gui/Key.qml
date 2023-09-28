import QtQuick 2.0

Item {
    id: itemRoot
    width: 50
    height: 50

    property alias letter: itemText.text
    property alias color: itemRect.color

    property int row
    property int idx
    property bool enabled: true

    signal keyPressed(key: string, row: int, index: int)

    function reset() {
        itemRoot.enabled = true;
        itemRect.color = "#abdbe3";
        itemText.color = "black";
    }

    Rectangle {
        id: itemRect
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
                if(itemRoot.enabled) {
                    parent.color = "#0967a4";
                    itemText.color = "white"
                }
            }

            onExited: {
                if(itemRoot.enabled) {
                    parent.color = "#abdbe3";
                    itemText.color = "black"
                }
            }

            onPressed: {
                if(itemRoot.enabled)
                    parent.color = "#e28743";
            }

            onReleased: {
                if(itemRoot.enabled)
                    parent.color = "#0967a4";
            }

            onClicked: {
                if(itemRoot.enabled)
                    itemRoot.keyPressed(itemText.text, itemRoot.row, itemRoot.idx);
            }
        }
    }

    Component.onCompleted: {
        keyPressed.connect(root.onKeyPressed);
    }
}
