import QtQuick 2.0

Item {
    id: victory_root

    property int victoryScore

    Rectangle {
        color: "black"
        anchors.fill: parent
        opacity: 0.8
    }

    Rectangle {
        id: victory_rect
        width: 0.8 * victory_root.width
        height: 0.4 * victory_root.height
        radius: 8
        anchors.centerIn: victory_root
        color: "white"

        Text {
            id: victory_title
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin:10
            text: qsTr("VICTORY")
            font.pixelSize: 30
            font.bold: true
            color: "#C00000"
        }

        Text {
            id: victory_score
            width: victory_rect.width
            anchors.top: victory_title.bottom
            anchors.topMargin: 3
            text: qsTr("Score: ") + victory_root.victoryScore
            font.pixelSize: 20
            font.bold: true

            horizontalAlignment: Text.AlignHCenter
        }

        Image {
            id: victory_cup
            source: "../assets/img/cup.png"
            width: 0.7 * parent.width
            anchors.centerIn: parent
            anchors.topMargin: 10
            fillMode: Image.PreserveAspectFit
        }

        Key {
            id: victory_btn_newgame
            width: parent.width * 0.4
            letter: "NEW GAME"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: victory_rect.bottom
            anchors.topMargin: 5
            anchors.bottomMargin: 10

            MouseArea {
                id: victory_btn_newgame_mouse
                anchors.fill: parent
                onPressed: {
                    parent.color = "#e28743";
                }

                onReleased: {
                    parent.color = "#0967a4";
                }

                onClicked: {
                    victory_root.visible = false;
                }
            }
        }
    }
}
