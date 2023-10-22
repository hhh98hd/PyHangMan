import QtQuick 2.0

Item {
    id: game_over_root

    property alias gameOverText : game_over_text.text
    property int gameOverScore

    Rectangle {
        color: "black"
        anchors.fill: parent
        opacity: 0.8
    }

    Rectangle {
        id: game_over_rect
        width: 0.8 * game_over_root.width
        height: 0.8 * game_over_root.height
        radius: 8
        anchors.centerIn: game_over_root
        color: "white"

        Text {
            id: game_over_text
            width: game_over_rect.width
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            text: qsTr("")
            font.pixelSize: 26
            wrapMode: Text.WordWrap

            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: game_over_title
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: game_over_text.bottom
            anchors.topMargin:10
            text: qsTr("GAME OVER")
            font.pixelSize: 30
            font.bold: true
            color: "#C00000"
        }

        Text {
            id: game_over_score
            width: game_over_rect.width
            anchors.top: game_over_title.bottom
            anchors.topMargin: 3
            text: qsTr("Score: ") + game_over_root.gameOverScore
            font.pixelSize: 20
            font.bold: true

            horizontalAlignment: Text.AlignHCenter
        }

        Image {
            id: img_character_dead
            width: 0.8 * character.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: game_over_score.bottom
            anchors.topMargin: 10
            source: "../assets/img/character_dead.png"
            fillMode: Image.PreserveAspectFit
        }

        Key {
            id: game_over_btn_restart
            width: parent.width * 0.4
            letter: "RESTART"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: game_over_rect.bottom
            anchors.topMargin: 5
            anchors.bottomMargin: 10

            MouseArea {
                id: game_over_btn_restart_mouse
                anchors.fill: parent
                onPressed: {
                    parent.color = "#e28743";
                }

                onReleased: {
                    parent.color = "#0967a4";
                }

                onClicked: {
                    game_over_root.visible = false;
                }
            }
        }
    }
}
