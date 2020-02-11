--
-- Pregunta
-- ===========================================================================
-- 
-- El archivo `truck_event_text_partition.csv` tiene la siguiente estructura:
-- 
--   driverId       INT
--   truckId        INT
--   eventTime      STRING
--   eventType      STRING
--   longitude      DOUBLE
--   latitude       DOUBLE
--   eventKey       STRING
--   correlationId  STRING
--   driverName     STRING
--   routeId        BIGINT
--   routeName      STRING
--   eventDate      STRING
-- 
-- Escriba un script en Pig que carge los datos y obtenga los primeros 10 
-- registros del archivo para las primeras tres columnas, y luego, ordenados 
-- por driverId, truckId, y eventTime. 
--
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
-- 
--  >>> Escriba su respuesta a partir de este punto <<<
-- 
fs -rm -f -r truck_event_text_partition.csv
fs -put truck_event_text_partition.csv

file = LOAD 'truck_event_text_partition.csv' USING PigStorage(',')
    AS (driverId:INT,
		truckId:INT,
		eventTime:CHARARRAY,
		eventType:CHARARRAY,
		longitude:DOUBLE,
		latitude:DOUBLE,
		eventKey:CHARARRAY,
		correlationId:CHARARRAY,
		driverName:CHARARRAY,
		routeId:BIGINTEGER,
		routeName:CHARARRAY,
		eventDate:CHARARRAY);

file = LIMIT file 10;
file = ORDER file BY $0,$1,$2;
result = FOREACH file GENERATE CONCAT((CHARARRAY)$0,',',(CHARARRAY)$1,',',$2);
dump result;

STORE result INTO 'output';

fs -copyToLocal output output