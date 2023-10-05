import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

ApplicationWindow {
    id: window
    visible: true
    width: 600
    height: 800
    title: "Hang Man"

    signal requestNewWord();
    signal updateScore(score: int);
    signal correctChoice();
    signal wrongChoice();

    function onNewWordReceived(word: string, hiddenWord: string, numHidden: int) {
        root.hiddenWord = word;
        root.displayWord = hiddenWord;
        root.numHidden = numHidden;
        root.lives = 5;
    }

    Rectangle {
        id: root
        anchors.fill: parent
        color: "transparent"

        property string hiddenWord: ""
        property string displayWord: ""
        property int numHidden: 0
        property var usedKeys: [];
        property int lives: 5;

        function onKeyPressed(key : string, row : int, index : int) {
            var isCorrect = false

            usedKeys.push([row, index]);

            for(var i = 0; i < hiddenWord.length; i++) {
                if(hiddenWord.charAt(i) === key) {
                    keyboard.setKeyColor(row, index, "green")
                    displayWord = displayWord.substr(0, i) + key + displayWord.substr(i + 1)
                    numHidden -= 1
                    isCorrect = true
                }
            }

            if(!isCorrect) {
                window.wrongChoice();
                keyboard.setKeyColor(row, index, "red")
                character.y += 80;
                lives -= 1;

            } else {
                window.correctChoice();
            }

            // Guessed all leters
            if(numHidden <= 0) {
                window.updateScore(100);
                window.requestNewWord();
                character.y = -450;

                for(const k of usedKeys) {
                    keyboard.resetKeyState(k[0], k[1])
                }
            }
        }

        Image {
            id: character
            height: window.height * 0.85
            y: -450
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../assets/img/character.png"
            fillMode: Image.PreserveAspectFit

            Behavior on y {
                PropertyAnimation {
                    duration: 500
                    easing.type: Easing.OutBounce
                }
            }
        }

        Keyboard {
            id: keyboard
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: root.bottom
            anchors.bottomMargin: 8
        }

        Text {
            id: text
            z: 9999
            anchors.horizontalCenter: root.horizontalCenter
            anchors.top: root.top
            anchors.topMargin: 8
            text: root.displayWord
            font.bold: true
            font.pixelSize: 25
            font.letterSpacing: 4

        }

        Rectangle {
            width: window.width
            height: text.height + 10
            color: "white"
            opacity: 0.8
        }
    }
}
