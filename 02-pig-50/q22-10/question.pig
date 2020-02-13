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
--        color
--    FROM 
--        u
--    WHERE 
--        color REGEXP '.n';
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
p= FILTER u BY (LOWER(SUBSTRING(color,((int)(SIZE(color)-1))
                                ,(int)SIZE(color)))) == 'n';
q= FOREACH p GENERATE CONCAT((CHARARRAY)firstname,',',(CHARARRAY)color);
dump q;
STORE q INTO 'output';
fs -copyToLocal output output
