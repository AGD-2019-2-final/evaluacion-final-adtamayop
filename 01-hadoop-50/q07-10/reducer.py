import sys
import itertools
from operator import itemgetter

if __name__ == '__main__':
    class Reducer:    
        def __init__(self, stream):
            self.stream = stream

        def emit(self, key):
            sys.stdout.write("{}\n".format(key)) 

        def reduce(self):           
            for i in self:
                i = i.replace('\n','').split('\t')[1:]
                i = "    ".join(i)
                self.emit(key=i)
            
        def __iter__(self):

            for line in self.stream:               
                yield (line)
                
    reducer = Reducer(sys.stdin)
    reducer.reduce()