import random

from PySide6.QtCore import QObject, Signal

from utils import (load_dictionary, log)
from configs import (
    RANDOM_SEED,
    HIDDEN_PORTION)

class HangMan(QObject):
    new_word_ready_event = Signal(str, str, int)
    
    def __init__(self) -> None:
        super().__init__()
        
        # Events
        log('[HangMan::HangMan] Initializing ...')
                        
        # To check if a word's already appeared
        self.word_to_occurences = dict()
        
        # To check if a letter's already been used
        self.letter_to_occurences  = dict()
        for i in range(ord('A'), ord('Z') + 1):
            self.letter_to_occurences[chr(i)] = 0
        
        self.data = load_dictionary()
        if 0 == len(self.data):
            raise Exception('This dictionary is empty!')
        log('[HangMan::HangMan] Found {len} words in the dictionary'.format(len=len(self.data)))    
                            
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
            
            if word not in self.word_to_occurences:
                self.word_to_occurences[word] = 0
                
                log("[HangMan::get_random_word] Returning \"" + word + "\"\n")
                
                return word.upper()
            
    def hide_letters(self, word: str) -> str:
        hidden_word = ""
                
        if HIDDEN_PORTION < 1:
            hidden_letter_num = int(len(word) * HIDDEN_PORTION)
            log("[HangMan::hide_letters] Hide {num} letters".format(num=hidden_letter_num))
            
            indexs = random.sample([* range(0, len(word))], hidden_letter_num)
            
            hidden_word = word
            for idx in indexs:
                if word[idx] == " " or word[idx] == "_":
                    continue
                else:
                    hidden_word = hidden_word[: idx] + "_" + hidden_word[idx + 1 :]
        else:
            log("[HangMan::hide_letters] Hide all letters")
            for chr in word:
                if chr != " ": 
                    hidden_word += "_"
                else:
                    hidden_word += " "
        
        log("[HangMan::hide_letters] {w} -> {hw}\n".format(w=word, hw=hidden_word))
        
        return (word, hidden_word, len(indexs))
        
    ################################################# EVENT HANDLERS #################################################
    
    def on_word_request_received(self):
        log("[HangMan::on_word_request_received] GUI requests a new word\n")
        (word, hidden_word, hidden_num) = self.hide_letters( self.get_random_word())
        self.new_word_ready_event.emit(word, hidden_word, hidden_num)
        
