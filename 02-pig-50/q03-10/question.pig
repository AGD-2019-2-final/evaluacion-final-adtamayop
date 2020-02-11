-- Pregunta
-- ===========================================================================
-- 
-- Obtenga los cinco (5) valores más pequeños de la 3ra columna.
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
fs -rm -f -r data.tsv
fs -put data.tsv

file = LOAD 'data.tsv' USING PigStorage('\t')
    AS (col1:CHARARRAY,
        col2:CHARARRAY,
        col3:INT);
DUMP file;

file = ORDER file BY $2;
Resp = LIMIT file 5;
Resp = FOREACH Resp GENERATE $2;
DUMP Resp;

STORE Resp INTO 'output';

fs -copyToLocal output output