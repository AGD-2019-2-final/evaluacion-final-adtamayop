import sys
import itertools
from operator import itemgetter

if __name__ == '__main__':
    class Reducer:
    
        def __init__(self, stream):
            self.stream = stream

        def emit(self, key,date,value):
            sys.stdout.write("{}\t{}\t{}\n".format(key,date,value)) 

        def reduce(self):
            lista = []

            for i in self:
                i = i.replace('\n','')
                i = i.split('   ')
                
                if len(i) >1:
                    i[2] = int(i[2])
                    lista.append(i) 
            

            lista = sorted([row for row in lista], key=itemgetter(2),reverse=False)
            
            lista = lista[0:6]
            for i in range(len(lista)):
                self.emit(key=lista[i][0], date=lista[i][1],value=lista[i][2])  
            
        def __iter__(self):

            for line in self.stream:               
                yield (line)
                
    reducer = Reducer(sys.stdin)
    reducer.reduce()