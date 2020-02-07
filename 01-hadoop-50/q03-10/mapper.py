import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
#! /usr/bin/env python

if __name__ == "__main__":

    # input comes from STDIN (standard input)
    for line in sys.stdin:
        line = line.strip()
        line = line.split(',')

        if len(line) >=2:
            purpose = line[0]
            amount = line[1]
            

            sys.stdout.write("{},{}\n".format(purpose, amount))