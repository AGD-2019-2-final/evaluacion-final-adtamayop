import sys
#
# >>> Escriba el codigo del reducer a partir de este punto <<<
#
if __name__ == '__main__':
    Letra = {}
    for line in sys.stdin:
        line = line.strip()
        k = line.split(',')[0]
        conta = line.split(',')[1]
        conta=int(conta)
        if k in Letra.keys():
            Letra[k].append(conta)
        else:
            Letra[k]=[]
            Letra[k].append(conta)
    for k in Letra.keys():
        suml =sum(Letra[k])
        sys.stdout.write("{},{}\n".format(k, suml))