import sys

if __name__ == "__main__":
    class Mapper:
    
        def __init__(self, stream):       
            self.stream = stream

        def emit(self,claves,key,fecha,numero):      
            sys.stdout.write("{}\t{}\t{}\t{}\n".format(claves,key,fecha,numero))

        def map(self):
            for word in self:
                indice = word.split()[0]
                fecha = word.split()[1]
                numero = word.split()[2]
                # claves creadas para que el combiner interno de hadoop
                #  se lo tire organizado al reduce
                claves = '{},{:0>4}'.format(indice,numero)
                self.emit(claves=claves,key=indice,fecha=fecha,numero=numero)        

        def __iter__(self):
            for line in self.stream:                             
                yield line
                
    mapper = Mapper(sys.stdin)  
    mapper.map()