-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
-- columna 3. En otras palabras, cuántos registros hay que tengan la clave 
-- `aaa`?
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

fs -rm -f -r data.tsv
fs -put data.tsv

u = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:BAG{}, f3:MAP[]);
v = FOREACH u GENERATE FLATTEN(KEYSET(f3)) as f;
grupos = GROUP v BY f;
cuenta = FOREACH grupos GENERATE CONCAT((CHARARRAY)group, ',',(CHARARRAY)COUNT(v));
dump cuenta;

STORE cuenta INTO 'output';
fs -copyToLocal output output