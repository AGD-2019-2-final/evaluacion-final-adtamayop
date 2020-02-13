-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código equivalente a la siguiente consulta SQL.
-- 
--    SELECT 
--        birthday, 
--        DATE_FORMAT(birthday, "yyyy"),
--        DATE_FORMAT(birthday, "yy"),
--    FROM 
--        persons
--    LIMIT
--        5;
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
date_data = FOREACH u generate CONCAT((CHARARRAY)ToString(ToDate(birthday,'yyyy-MM-dd'),'yyyy'),',',(CHARARRAY)ToString(ToDate(birthday,'yyyy-MM-dd'),'yy'));
dump date_data;
STORE date_data INTO 'output';
fs -copyToLocal output output

