import sys


if __name__ == "__main__":
    class Mapper:
    
        def __init__(self, stream):       
            self.stream = stream

        def emit(self, key, value):      
            sys.stdout.write("{}\t{}\n".format(key, value))

        def map(self):
            for word in self:
                letra = word.split('   ')[0]
                valor = word.split('   ')[2]
                
                self.emit(key=letra.strip(), value=valor.strip())        

        def __iter__(self):

            for line in self.stream:                              
                yield line
                
    mapper = Mapper(sys.stdin)  
    mapper.map()