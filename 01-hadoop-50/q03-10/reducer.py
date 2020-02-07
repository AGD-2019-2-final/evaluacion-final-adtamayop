#
# >>> Escriba el codigo del reducer a partir de este punto <<<
#
#!/usr/bin/env python
import sys

if __name__ == '__main__':
    ## cada linea de texto recibida es una
    ## entrada clave \tabulador valor
    b=[]
    for line in sys.stdin:
        line = line.strip()
        purpose, amount = line.split(',')
        amount=int(amount)
        b.append((purpose,amount))
        

    b.sort(key=lambda b: b[1])
    for i in b:
        sys.stdout.write("{}\n".format((i[0]+','+str(i[1]))))