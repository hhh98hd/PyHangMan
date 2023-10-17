import sys

from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

from HangMan import HangMan
from configs import QML_MAIN

if __name__ == '__main__' :
    print('Starting ...\n')
    
    app = QApplication()
    engine = QQmlApplicationEngine()
    
    engine.quit.connect(app.quit)
    engine.load(QML_MAIN)
    
    game = HangMan()
    root = engine.rootObjects()[0]
    
    # Connect evens to handlers
    root.requestNewWord.connect(game.on_word_request_received)
    root.updateScore.connect(game.on_score_updated)
    root.correctChoice.connect(game.on_correct_choice)
    root.wrongChoice.connect(game.on_wrong_choice)
    root.finishWord.connect(game.on_word_finished)
    game.new_word_ready_event.connect(root.onNewWordReceived)
    
    # Send the initial word
    word, hint, definition  = game.get_random_word()
    (word, hidden_word, hidden_num) = game.hide_letters(word)
    game.new_word_ready_event.emit(word, hidden_word, hint, definition, hidden_num)
    
    sys.exit(app.exec())
