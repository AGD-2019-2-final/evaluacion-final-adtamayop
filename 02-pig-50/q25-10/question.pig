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
--        SUBSTRING_INDEX(firstname, 'a', 1)
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
q= FOREACH u GENERATE INDEXOF(firstname,'a',1) as index;
--la respuesta del ejercicio debería de ser:
-- q= FOREACH u GENERATE firstname,INDEXOF(firstname,'a',1) as index;
--p = FOREACH q GENERATE 
--(CASE 
-- WHEN index == -1 THEN firstname
-- WHEN index != -1 THEN SUBSTRING(firstname,0,(int)index)
-- END);
dump q;
STORE q INTO 'output';
fs -copyToLocal output output
