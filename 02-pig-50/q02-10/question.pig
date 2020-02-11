-- Pregunta
-- ===========================================================================
-- 
-- Ordene el archivo `data.tsv`  por letra y valor (3ra columna).
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
-- 
--  >>> Escriba el codigo del mapper a partir de este punto <<<
-- 
fs -rm -f -r data.tsv
fs -put data.tsv

file = LOAD 'data.tsv' AS (
        letra:CHARARRAY, 
        fecha:CHARARRAY, 
        cantidad:INT);

y = ORDER file BY letra,cantidad;
dump y;

STORE y INTO 'output';

fs -copyToLocal output output