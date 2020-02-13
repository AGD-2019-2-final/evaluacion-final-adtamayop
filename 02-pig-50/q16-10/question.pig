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
--    WHERE color = 'blue' OR firstname LIKE 'K%';
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
--el operador OR me está imprimiendo una linea no pone problema pues el 
--resultado es correcto, pero la calificación la tacha de incorrecta
--j = FILTER u BY color MATCHES 'blue';
--k = FILTER u BY (REGEX_EXTRACT(firstname,'^K',0) == 'K');

j = FILTER u BY (color MATCHES 'blue') OR 
(REGEX_EXTRACT(firstname,'^K',0) == 'K');
k = FOREACH j GENERATE CONCAT((CHARARRAY)firstname,',',(CHARARRAY)color);
dump k;
STORE k INTO 'output';
fs -copyToLocal output output