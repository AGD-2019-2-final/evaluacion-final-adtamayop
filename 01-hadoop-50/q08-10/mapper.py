import sys


if __name__ == "__main__":
    class Mapper:
    
        def __init__(self, stream):       
            self.stream = stream

        def emit(self, key, value):      
            sys.stdout.write("{}\t{}\n".format(key, value))

        def map(self):
            for word in self:          
                self.emit(key=word[0], value=word[1])  
                
        def __iter__(self):

            for line in self.stream:
                key = line.split("   ")[0]
                val = line.split("   ")[2]
                val = int(val)
                yield (key, val)
                
    mapper = Mapper(sys.stdin)  
    mapper.map()