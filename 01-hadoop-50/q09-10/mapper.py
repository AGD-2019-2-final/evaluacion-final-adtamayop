import sys


if __name__ == "__main__":
    class Mapper:
    
        def __init__(self, stream):       
            self.stream = stream

        def emit(self, key):      
            sys.stdout.write("{}".format(key))

        def map(self):
            for word in self:          
                self.emit(key=word)        

        def __iter__(self):

            for line in self.stream:                             
                yield line
                
    mapper = Mapper(sys.stdin)  
    mapper.map()