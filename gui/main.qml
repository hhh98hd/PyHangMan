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

        function onKeyPressed(key : string) {
            var idx = -1

            for(var i = 0; i < hiddenWord.length; i++) {
                if(hiddenWord.charAt(i) === key) {
                    displayWord = displayWord.substr(0, i) + key + displayWord.substr(i + 1)
                }
            }

            if(-1 == idx) {

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
