import sys
import itertools

if __name__ == '__main__':
    class Reducer:
    
        def __init__(self, stream):
            self.stream = stream

        def emit(self, key, value,mean):
            sys.stdout.write("{}\t{}\t{}\n".format(key,value,mean)) 

        def reduce(self):

            for key, group in itertools.groupby(self, lambda x: x[0]):
                suma = 0
                cont = 0
                
                for _, val in group:
                    suma += val                
                    cont +=1
                
                promedio = suma/cont
                
                
                self.emit(key=key, value=float(suma),mean=promedio)

        def __iter__(self):

            for line in self.stream:
                key, val = line.split("\t") 
                val = int(val)
                yield (key, val)
                
    reducer = Reducer(sys.stdin)
    reducer.reduce()
