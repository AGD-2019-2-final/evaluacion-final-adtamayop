import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
if __name__ == "__main__":
    for line in sys.stdin:
        num = line.split('\t')[0]
        key = line.split('\t')[1]
        key= key.rstrip('\r\n')

        key_sep = key.split(',')
        
        for i in range(len(key)):
            sys.stdout.write("{}\t{}\n".format(str(key[i]),num.zfill(3)))