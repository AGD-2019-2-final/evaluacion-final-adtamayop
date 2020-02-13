-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código equivalente a la siguiente consulta SQL.
-- 
--    SELECT 
--        firstname, 
--        LOCATE('ia', firstname) 
--    FROM 
--        u;
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
fs -rm -f -r data.csv
fs -put data.csv
--
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
q= FOREACH u GENERATE INDEXOF(firstname,'ia',1) as index;
dump q;
STORE q INTO 'output';
fs -copyToLocal output output
