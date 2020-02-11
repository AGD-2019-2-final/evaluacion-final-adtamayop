-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
-- aparece cada letra minúscula en la columna 2.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
fs -rm -f -r data.tsv
fs -put data.tsv

u = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:BAG{},f3:CHARARRAY);
r = FOREACH u GENERATE FLATTEN(f2) as f;
grupos = GROUP r BY f;
cuenta = FOREACH grupos GENERATE group, COUNT(r);
DUMP cuenta;

STORE cuenta INTO 'output';

fs -copyToLocal output output