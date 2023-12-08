# PyHangMan
This game is my toolkit for ANU course COMP6250 - Professional Practice I. It is based on the traditional game "Hang Man" and the player's task is very simple: Guess the word before running out of turns (when the character touches the saw).


https://github.com/hhh98hd/PyHangMan/assets/26799260/13f74332-a0d3-4715-8d2f-af8ab5c43bd7



## How to install?
- **Method 1: Build from source**
1. Pull this repository
2. You can play direcly with the command (from the game's directory): **python main.py**. Or you can build it using **PyInstaller**.

- **Method 2: Use pre-built game**
1. Download the pre-built game from [here](https://drive.google.com/drive/folders/1efIpZXJ_zjfRoSJugCwbCXKmd46uaL2h?usp=sharing).
2. Run **main.exe**

## How to play?
1.1 If you have pulled this repository to your local, you can play by using the command **python main.py** from the game's directory.
1.2 If you have built or downloaded the pre-built game, you can play directly by clicking on **main.exe**.

![guide](https://github.com/hhh98hd/PyHangMan/assets/26799260/68b31217-4172-47e4-9fbd-ab74f4d36fe7)

2. While in game, you need to guess the hidden word by selecting letters on the screen. If you choose the correct letter, it will turn green. The letter will turn red vice versa.
3. If you get stuck, you may click on the hitn button (the one with a lightbulb) for hint. Note that using a hint does not affect your score.
4. If you make too many incorrect choices (5 times), the character will be shredded by the saw and GAME OVER.

   ![game_over](https://github.com/hhh98hd/PyHangMan/assets/26799260/31ac4950-e1f0-47c2-9ab5-a57318b3c0ae)

## Update the word list
If you wish to update the word list, you can modify [dictionary](/data/dictionary.txt). Plese follow below rules when updating the dictionary:
1. Each line must has the following format: **word@hint@definition**. If you do not want to have a hint or definition, please use **word@@definition** or **word@hint@"
2. Each word must be on 1 line only.

## Acknowledgements
This game is not for commercial purposes.
External resources
Components from [QtFrameWork](https://www.qt.io/product/framework).
- Sound effects from https://www.freesoundeffects.com.
- The gameover soundtrack: Track 06 (Ian Livingstone - Heavy Weapon).
