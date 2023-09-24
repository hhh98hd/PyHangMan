import random

from utils import load_dictionary
from configs import (
    RANDOM_SEED,
    LIVES)

class HangMan():
    def __init__(self) -> None:
        # To check if a word's already appeared
        self.word_to_occurences = dict()
        # To check if a letter's already been used
        self.letter_to_occurences  = dict()
        
        self.data = load_dictionary()
        if 0 == len(self.data):
            raise Exception('This dictionary is empty!')    
                            
        self.score = 0
        
        if RANDOM_SEED != 'NONE':
            random.seed(RANDOM_SEED)
            
    def get_random_word(self) -> str:
        # To avoid getting duplicated words        
        while(True):
            rand_idx = random.randint(0, len(self.data) - 1)
            word = self.data[rand_idx]
            
            if word not in self.word_to_occurences:
                self.word_to_occurences[word] = 0
                return word
            
    # EVENTS
            
    # EVENT HANDLERS #
    def on_key_chosen(key : str):
        pass
    
    def on_key_pressed(key : str):
        if(not key.isalpha()):
            return
        
        
                