import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: window
    visible: true
    width: 600
    height: 500
    title: "Hang Man"

    Rectangle {
        id: root
        anchors.fill: parent
        color: "transparent"

        property string hiddenWord: "SYSTEM THINKING"
        property string displayWord: "_Y___M _H__K_NG"
        property int numHidden: 8
        property var usedKeys: [];

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

            if(!isCorrect)
                keyboard.setKeyColor(row, index, "red")

            // Victory
            if(numHidden <= 0) {
                displayWord = "_Y___M _H__K_NG";
                numHidden = 8;

                for(const k of usedKeys) {
                    keyboard.resetKeyState(k[0], k[1])
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
            anchors.horizontalCenter: root.horizontalCenter
            anchors.top: root.top
            anchors.topMargin: 8
            text: root.displayWord
            font.bold: true
            font.pixelSize: 20
            font.letterSpacing: 4
        }
    }
}
