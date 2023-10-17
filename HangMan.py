import random
from time import sleep

from PySide6.QtCore import QObject, QUrl, Signal
from PySide6 import QtMultimedia

from utils import (load_dictionary, log)
from configs import (
    WORD_SPLIT,
    WORD_DEFINITION_SPLIT,
    RANDOM_SEED,
    HIDDEN_PORTION,
    CORRECT_SOUND,
    WRONG_SOUND,
    COMPLETETION_SOUND)

class HangMan(QObject):
    new_word_ready_event = Signal(str, str, str, str, int)
    
    def __init__(self) -> None:
        super().__init__()
        
        log('[HangMan::HangMan] Initializing ...')
                        
        # To check if a word's already appeared
        self.word_to_occurences = dict()
        # To check if a letter's already been used
        self.letter_to_occurences  = dict()
        for i in range(ord('A'), ord('Z') + 1):
            self.letter_to_occurences[chr(i)] = 0
        # Load list of words
        self.data = load_dictionary()
        if 0 == len(self.data):
            raise Exception('This dictionary is empty!')
        log('[HangMan::HangMan] Found {len} words in the dictionary'.format(len=len(self.data)))
        
        # Load sound effects
        self.correct_sound = QtMultimedia.QSoundEffect()
        self.correct_sound.setSource(QUrl.fromLocalFile(CORRECT_SOUND))
        self.correct_sound.setLoopCount(1)
        
        self.wrong_sound = QtMultimedia.QSoundEffect()
        self.wrong_sound.setSource(QUrl.fromLocalFile(WRONG_SOUND))
        self.wrong_sound.setLoopCount(1)
        
        self.completetion_sound = QtMultimedia.QSoundEffect()
        self.completetion_sound.setSource(QUrl.fromLocalFile(COMPLETETION_SOUND))
        self.completetion_sound.setLoopCount(1)
                                    
        self.score = 0
        
        if RANDOM_SEED != 'NONE':
            log('[HangMan::HangMan] Using {seed} as random seed'.format(seed=RANDOM_SEED))
            random.seed(RANDOM_SEED)
            
        log('[HangMan::HangMan] Initialization completed!\n')
    
    def get_random_word(self) -> str:
        # To avoid getting duplicated words        
        while(True):
            rand_idx = random.randint(0, len(self.data) - 1)
            word = self.data[rand_idx]
            word, extra_info = word.split(WORD_SPLIT)
            hint, definition = extra_info.split(WORD_DEFINITION_SPLIT)
            
            if word not in self.word_to_occurences:
                self.word_to_occurences[word] = 0
                
                log("[HangMan::get_random_word] Returning \"" + word + "\"\n")
                
                return word.upper(), hint, definition
            
    def hide_letters(self, word: str) -> str:
        hidden_word = ""
                
        if HIDDEN_PORTION < 1:
            hidden_letter_num = int(len(word) * HIDDEN_PORTION)
            
            indexs = random.sample([* range(0, len(word))], hidden_letter_num)
            hidden_num = 0
            
            hidden_word = word
            for idx in indexs:
                if word[idx] == " " or word[idx] == "_":
                    continue
                else:
                    hidden_word = hidden_word[: idx] + "_" + hidden_word[idx + 1 :]
                    hidden_num += 1
            log("[HangMan::hide_letters] Hide {num} letters".format(num=hidden_num))
        else:
            log("[HangMan::hide_letters] Hide all letters")
            for chr in word:
                if chr != " ": 
                    hidden_word += "_"
                    hidden_num += 1
                else:
                    hidden_word += " "
        
        log("[HangMan::hide_letters] {w} -> {hw}\n".format(w=word, hw=hidden_word))
        
        return (word, hidden_word, hidden_num)
        
    ################################################# EVENT HANDLERS #################################################
    
    def on_word_request_received(self):
        log("[HangMan::on_word_request_received] GUI requests a new word\n")
        word, hint, definition  = self.get_random_word()
        (word, hidden_word, hidden_num) = self.hide_letters(word)
        self.new_word_ready_event.emit(word, hidden_word, hint, definition, hidden_num)

    def on_score_updated(self, score):
        self.score += score
        log("[HangMan::on_score_updated] New score: {score}\n".format(score=self.score))
        
    def on_correct_choice(self):
        log("[HangMan::on_correct_choice] Received request to play sound\n")
        self.correct_sound.play()
    
    def on_wrong_choice(self):
        log("[HangMan::on_wrong_choice] Received request to play sound\n")
        self.wrong_sound.play()

    def on_word_finished(self):
        log("[HangMan::on_word_finished] Received request to play sound\n")
        self.completetion_sound.play()
        pass
