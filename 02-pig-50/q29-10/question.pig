-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código en Pig para manipulación de fechas que genere la siguiente 
-- salida.
-- 
--    1971-07-08,jul,07,7
--    1974-05-23,may,05,5
--    1973-04-22,abr,04,4
--    1975-01-29,ene,01,1
--    1974-07-03,jul,07,7
--    1974-10-18,oct,10,10
--    1970-10-05,oct,10,10
--    1969-02-24,feb,02,2
--    1974-10-17,oct,10,10
--    1975-02-28,feb,02,2
--    1969-12-07,dic,12,12
--    1973-12-24,dic,12,12
--    1970-08-27,ago,08,8
--    1972-12-12,dic,12,12
--    1970-07-01,jul,07,7
--    1974-02-11,feb,02,2
--    1973-04-01,abr,04,4
--    1973-04-29,abr,04,4
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
date_data = FOREACH u generate birthday,
ToString( ToDate(birthday,'yyyy-MM-dd'), 'MMM' ) as mes;

date_data = FOREACH date_data GENERATE CONCAT((CHARARRAY)birthday,',',(CHARARRAY)(CASE     
                              WHEN mes == 'Jan' THEN 'ene' 
                              WHEN mes == 'Feb' THEN 'feb' 
                              WHEN mes == 'Mar' THEN 'mar' 
                              WHEN mes == 'May' THEN 'may' 
                              WHEN mes == 'Apr' THEN 'abr' 
                              WHEN mes == 'Jun' THEN 'jun'
                              WHEN mes == 'Jul' THEN 'jul' 
                              WHEN mes == 'Aug' THEN 'ago' 
                              WHEN mes == 'Sep' THEN 'sep' 
                              WHEN mes == 'Oct' THEN 'oct'
                              WHEN mes == 'Nov' THEN 'nov' 
                              WHEN mes == 'Dec' THEN 'dic' 
                              END),',',
                              (CHARARRAY)(CASE
            WHEN GetMonth(ToDate(birthday,'yyyy-MM-dd')) < 10 THEN 
            CONCAT('0',(chararray)GetMonth(ToDate(birthday,'yyyy-MM-dd')))
            ELSE (chararray)GetMonth(ToDate(birthday,'yyyy-MM-dd'))
            END),',',(chararray)GetMonth(ToDate(birthday,'yyyy-MM-dd')));

                              
dump date_data;
STORE date_data INTO 'output';
fs -copyToLocal output output