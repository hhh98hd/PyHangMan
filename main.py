import sys

from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

from HangMan import HangMan
from configs import QML_MAIN

if __name__ == '__main__' :
    print('Starting ...')
    
    game = HangMan()
    word = game.get_random_word()
    word = game.get_random_word()
    
    app = QApplication()
    engine = QQmlApplicationEngine()
    
    engine.quit.connect(app.quit)
    engine.load(QML_MAIN)
    
    sys.exit(app.exec())
    