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
    signal finishWord();

    function onNewWordReceived(word: string, hiddenWord: string, numHidden: int) {
        root.answer = word;
        root.displayWord = hiddenWord;
        root.numHidden = numHidden;
        root.lives = 5;
    }

    Rectangle {
        id: root
        anchors.fill: parent
        color: "transparent"

        property int initialY: -450
        property int timeBetweenWordsMs: 1500

        property string answer: ""
        property string displayWord: ""
        property int numHidden: 0;
        property var usedKeys: []
        property int lives: 5

        function onKeyPressed(key : string, row : int, index : int) {
            if(displayWord.includes(key) && answer.split(key).length - 1 == 1) {
                console.log(key + ' is already in the display word. Returning ...')
                return;
            }

            usedKeys.push([row, index]);

            var isCorrect = false;

            for(var i = 0; i < answer.length; i++) {
                if(displayWord.charAt(i) == " ")
                    continue;

                if(answer.charAt(i) === key) {
                    keyboard.setKeyColor(row, index, "green")
                    displayWord = displayWord.substr(0, i) + key + displayWord.substr(i + 1)
                    isCorrect = true
                }
            }

            if(!isCorrect) {
                window.wrongChoice();
                keyboard.setKeyColor(row, index, "red")
                character.y += 80;
                lives -= 1;
            } else if(isCorrect){
                window.correctChoice();
            }

            if(displayWord == answer) {
                timer.start();

                character.y = root.initialY;

                for(const k of root.usedKeys) {
                    keyboard.resetKeyState(k[0], k[1])
                }
            }
        }

        Image {
            id: character
            height: window.height * 0.85
            y: root.initialY
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../assets/img/character.png"
            fillMode: Image.PreserveAspectFit

            Behavior on y {
                PropertyAnimation {
                    duration: 550
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

        Timer {
            id: timer
            interval: root.timeBetweenWordsMs
            running: false
            repeat: false // one-shot timer

            onTriggered: {
                window.updateScore(100);
                window.requestNewWord();
                window.finishWord();
                window.updateScore(100);
                window.requestNewWord();
            }
        }
    }
}
