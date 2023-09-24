from configs import (
    DICT_PATH,
    LOGGING_DIR,
    LOGGING_ENABLED,
    LOG_TO_FILE
)
from datetime import datetime

file_name = LOGGING_DIR + datetime.now().strftime("%H%M%S_%d%b%y") + ".txt"

def load_dictionary():
    f = open(DICT_PATH, 'r')
    data =  f.readlines()
    return [word.strip() for word in data]

def log(msg):
    if LOGGING_ENABLED:
        now = datetime.now()
        time_str = now.strftime("%H:%M:%S.%f")[:-3]
        date_str = now.strftime("%d/%m/%y")
                
        dt_str = time_str + "-" + date_str
        
        log_msg = '[' + dt_str +'] ' + msg
        print(log_msg)
        
        if(LOG_TO_FILE):
            file = open(file_name, 'a')
            file.write(log_msg + '\n')

