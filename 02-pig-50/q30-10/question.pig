-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
-- salida.
-- 
--    1971-07-08,08,8,jue,jueves
--    1974-05-23,23,23,jue,jueves
--    1973-04-22,22,22,dom,domingo
--    1975-01-29,29,29,mie,miercoles
--    1974-07-03,03,3,mie,miercoles
--    1974-10-18,18,18,vie,viernes
--    1970-10-05,05,5,lun,lunes
--    1969-02-24,24,24,lun,lunes
--    1974-10-17,17,17,jue,jueves
--    1975-02-28,28,28,vie,viernes
--    1969-12-07,07,7,dom,domingo
--    1973-12-24,24,24,lun,lunes
--    1970-08-27,27,27,jue,jueves
--    1972-12-12,12,12,mar,martes
--    1970-07-01,01,1,mie,miercoles
--    1974-02-11,11,11,lun,lunes
--    1973-04-01,01,1,dom,domingo
--    1973-04-29,29,29,dom,domingo
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
            ToString( ToDate(birthday,'yyyy-MM-dd'), 'EEE' ) as dia;

date_data = FOREACH date_data GENERATE birthday,(CASE     
                              WHEN dia == 'Mon' THEN 'lunes' 
                              WHEN dia == 'Tue' THEN 'martes' 
                              WHEN dia == 'Wed' THEN 'miércoles' 
                              WHEN dia == 'Thu' THEN 'jueves' 
                              WHEN dia == 'Fri' THEN 'viernes' 
                              WHEN dia == 'Sat' THEN 'sábado'
                              WHEN dia == 'Sun' THEN 'domingo' 
                              END) as dia_semana;
date_data = FOREACH date_data GENERATE birthday,
(CASE
            WHEN GetDay(ToDate(birthday,'yyyy-MM-dd')) < 10 THEN 
            CONCAT('0',(chararray)GetDay(ToDate(birthday,'yyyy-MM-dd')))
            ELSE (chararray)GetDay(ToDate(birthday,'yyyy-MM-dd'))
            END) as casee,
                              GetDay(ToDate(birthday,'yyyy-MM-dd')) as dia,
                              SUBSTRING(dia_semana,0,3) as diaa,
                              dia_semana;
date_data = FOREACH date_data GENERATE CONCAT((CHARARRAY)birthday,',',(CHARARRAY)casee,',',(CHARARRAY)dia,',',(CHARARRAY)diaa,',',(CHARARRAY)dia_semana);   
                    
dump date_data;
STORE date_data INTO 'output';
fs -copyToLocal output output