import QtQuick 2.0

Item {
    id: rootKeyboard
    height: colKeyboard.height

    Column {
        id: colKeyboard
        spacing: 4
        anchors.horizontalCenter: parent.horizontalCenter

        Row {
            id: row1
            spacing: 4
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
                Key {
                    required property string modelData
                    letter: modelData
                }
            }
        }

        Row {
            id: row2
            spacing: 4
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
                Key {
                    required property string modelData
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
                model: ["Z", "X", "C", "V", "B", "N", "M"]
                Key {
                    required property string modelData
                    letter: modelData
                }
            }
        }
    }
}
