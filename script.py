import os
import string
import random
import shutil

path = os.path.abspath(__file__) + '\\..\\Troll'

try:
    shutil.rmtree(path)
except Exception as e:
    pass

os.mkdir(path)

def generator(chars = string.ascii_uppercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(random.randint(4, 7)))

for i in range(100):
    try:
        os.mkdir(path + '\\' + str(i))
        for j in range(10):
            try:
                print('Troll\\' + str(i) + '\\' + str(j) + '.lua')
                file = open('Troll\\' + str(i) + '\\' + str(j) + '.lua', 'w+')
                gen = generator()
                print('return GANIN.gen(\'' + gen + '\')')
                file.write('return \'' + gen + '\'')
                print('writed')
                file.close()
                print('closed')
            except Exception as e:
                pass
    except Exception as e:
        pass
