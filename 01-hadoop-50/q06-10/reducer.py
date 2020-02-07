import sys
import itertools

if __name__ == '__main__':
    class Reducer:
    
        def __init__(self, stream):
            self.stream = stream

        def emit(self, key,value_max,value_min):
            sys.stdout.write("{}\t{}\t{}\n".format(key,value_max,value_min)) 

        def reduce(self):

            for key, group in itertools.groupby(self, lambda x: x[0]):
                flag = True
                mini = 0
                mini = 0
                for _, val in group:
                    if flag:
                        mini = float(val)
                        maxi = float(val)
                        flag = False
                        continue
                
                    valor = float(val)               

                    if(float(valor) < (mini)):
                        mini = float(val)

                    if((valor) > (maxi)):
                        maxi = float(val)
                    
                    

                self.emit(key=key,value_max=maxi,value_min=mini)
            
            
        def __iter__(self):

            for line in self.stream:                
                key, val = line.split("	") 
                val = float(val)
                yield (key, val)
                
    reducer = Reducer(sys.stdin)
    reducer.reduce()