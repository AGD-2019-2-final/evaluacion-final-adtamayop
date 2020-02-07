import sys
#
#  >>> Escriba el codigo del mapper a partir de este punto <<<
#
import collections
import csv
import re
if __name__ == "__main__":
    file = sys.stdin.readlines()
    #file = open('data.csv','r').readlines()
    file = [row[0:-1] for row in file]
    patron = re.compile('\t|\s+')
    datasub = [re.sub(patron,'~',x) for x in file]
    datasplit = [re.split('~',x) for x in datasub]
    month =[[x[1]][0].split('-')[1] for x in datasplit]

    for x in month:
        sys.stdout.write("{}\t1\n".format(x))