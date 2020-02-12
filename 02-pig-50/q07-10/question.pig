-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
-- la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
-- columna 3 separados por coma. La tabla debe estar ordenada por las 
-- columnas 1, 2 y 3.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

fs -rm -f -r data.tsv
fs -put data.tsv

u = LOAD 'data.tsv' USING PigStorage('\t')
    AS (col1:CHARARRAY,
        col2:BAG{t: TUPLE(p:CHARARRAY)},
        col3:MAP[]);

file = FOREACH u GENERATE $0,SIZE($1),SIZE($2);
file = ORDER file BY $0,$1,$2;
Resp = FOREACH file GENERATE CONCAT($0,',',(CHARARRAY)$1,',',(CHARARRAY)$2);
DUMP Resp;


STORE Resp INTO 'output';

fs -copyToLocal output output