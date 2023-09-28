import QtQuick 2.0

Item {
    id: rootKeyboard
    height: colKeyboard.height

    function setKeyColor(row: int, index: int, color: string) {
        var key
        switch(row) {
            case 1: {
                key = row1Repeater.itemAt(index);
                break;
            }

            case 2: {
                key = row2Repeater.itemAt(index);
                break;
            }

            case 3: {
                key = row3Repeater.itemAt(index);
                break;
            }
        }

        key.enabled = false;
        key.color = color;
    }

    function resetKeyState(row: int, index: int) {
        var key
        switch(row) {
            case 1: {
                key = row1Repeater.itemAt(index);
                break;
            }

            case 2: {
                key = row2Repeater.itemAt(index);
                break;
            }

            case 3: {
                key = row3Repeater.itemAt(index);
                break;
            }
        }

        key.reset();
    }

    Column {
        id: colKeyboard
        spacing: 4
        anchors.horizontalCenter: parent.horizontalCenter

        Row {
            id: row1
            spacing: 4
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                id: row1Repeater
                model: ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
                Key {
                    required property int index
                    required property string modelData

                    row: 1
                    idx: index
                    letter: modelData
                }
            }
        }

        Row {
            id: row2
            spacing: 4
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                id: row2Repeater
                model: ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
                Key {
                    required property int index
                    required property string modelData

                    row: 2
                    idx: index
                    letter: modelData
                }
            }
        }

        Row {
            id: row3
            spacing: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 2

            Repeater {
                id: row3Repeater
                model: ["Z", "X", "C", "V", "B", "N", "M"]
                Key {
                    required property int index
                    required property string modelData

                    row: 3
                    idx: index
                    letter: modelData
                }
            }
        }
    }
}
