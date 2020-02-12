-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
-- columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
-- registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
-- columna 3 es:
-- 
--   ((b,jjj), 216)
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
fs -rm -f -r data.tsv
fs -put data.tsv
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
u = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:BAG{}, f3:MAP[]);
v = FOREACH u GENERATE FLATTEN(f2) as sizef2,f3;
v = FOREACH v GENERATE sizef2,FLATTEN(KEYSET(f3)) as sizef3;
grupos = GROUP v BY (sizef2,sizef3);
cuenta = FOREACH grupos GENERATE group, COUNT(v);
dump cuenta;

STORE cuenta INTO 'output';

fs -copyToLocal output output