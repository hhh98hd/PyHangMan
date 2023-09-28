import random

from PySide6.QtCore import QObject, Property

from utils import (load_dictionary, log)
from configs import (
    RANDOM_SEED,
    LIVES)

class HangMan(QObject):
    
    def __init__(self) -> None:
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
        
        
        # QML Properties #
        
            
    def get_random_word(self) -> str:
        # To avoid getting duplicated words        
        while(True):
            rand_idx = random.randint(0, len(self.data) - 1)
            word = self.data[rand_idx]
            
            if word not in self.word_to_occurences:
                self.word_to_occurences[word] = 0
                
                log("[HangMan::get_random_word] Returning \"" + word + "\"\n")
                
                return word
                