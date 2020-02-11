-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra. 
-- Escriba el resultado a la carpeta `output` del directorio actual.
--
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
fs -rm -f -r data.tsv
fs -put data.tsv

file = LOAD 'data.tsv' AS (
        letra:CHARARRAY, 
        fecha:CHARARRAY, 
        cantidad:INT);
grupos = GROUP file BY letra;
cuenta = FOREACH grupos GENERATE group, COUNT(file);
DUMP cuenta;
STORE cuenta INTO 'output';

fs -copyToLocal output output