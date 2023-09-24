import sys

from PySide6.QtWidgets import QApplication, QMainWindow, QPushButton

from HangMan import HangMan
from utils import log

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("My App")
        button = QPushButton("Press Me!")
        button.setCheckable(True)
        button.clicked.connect(self.the_button_was_clicked) # Connect the signal to the slot
        self.setCentralWidget(button)

    def the_button_was_clicked(self): # This is the slot
        log("Clicked!")

if __name__ == '__main__':
    game = HangMan()
    
    app = QApplication()
    window = MainWindow()
    window.setFixedWidth(800)
    window.setFixedHeight(600)
    window.show()
    sys.exit(app.exec())
    