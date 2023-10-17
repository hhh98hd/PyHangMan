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

    function onNewWordReceived(word: string, hiddenWord: string, hint: string, definition: string, numHidden: int) {
        root.answer = word;
        root.displayWord = hiddenWord;
        root.hint = hint;
        root.definition = definition;
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
        property string hint: ""
        property string definition: ""
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

            // Completition
            if(displayWord == answer) {
                window.finishWord();

                timer.start();

                character.y = root.initialY;

                for(const k of root.usedKeys) {
                    keyboard.resetKeyState(k[0], k[1])
                }
            }
        }

        Rectangle {
            z: 999999
            id: btn_hint
            anchors.top: text_bar.bottom
            anchors.topMargin: 5
            anchors.left: text_bar.left
            anchors.leftMargin: 5
            width: 55
            height: 55
            radius: 8
            color: "#abdbe3"

            Image {
                id: img_lighbulb
                anchors.centerIn: parent
                width: 45
                height: 45
                source: "../assets/img/lightbulb.png"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    img_lighbulb.source = "../assets/img/lightbulb_hovered.png"
                    parent.color = "#0967a4";
                }

                onExited: {
                    img_lighbulb.source = "../assets/img/lightbulb.png"
                    parent.color = "#abdbe3";
                }

                onPressed: {
                    parent.color = "#e28743";
                }

                onReleased: {
                    parent.color = "#0967a4";
                }

                onClicked: {
                    console.log('HINT')
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
            id: text_bar
            anchors.verticalCenter: text.verticalCenter
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
                window.updateScore(100);
                window.requestNewWord();
            }
        }
    }
}
