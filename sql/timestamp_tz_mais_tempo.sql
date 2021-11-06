CREATE OR REPLACE FUNCTION timestamp_tz_mais_tempo (
  p_timestamp TIMESTAMP WITH TIME ZONE
, p_tempo     NUMBER
, p_unidade   VARCHAR2
)
RETURN TIMESTAMP WITH TIME ZONE
AS
  v_timestamp TIMESTAMP WITH TIME ZONE;
  
BEGIN
  SELECT CASE
           WHEN (p_unidade = 'D') THEN
             p_timestamp + p_tempo                  -- mais n dias
           WHEN (p_unidade = 'H') THEN
             p_timestamp + p_tempo / 24             -- mais n horas
           WHEN (p_unidade = 'M') THEN
             p_timestamp + p_tempo / (24 * 60)      -- mais n minutos
           WHEN (p_unidade = 'S') THEN
             p_timestamp + p_tempo / (24 * 60 * 60) -- mais n segundos
         END AS tempo
    INTO v_timestamp
    FROM dual;

  RETURN v_timestamp;
  
END timestamp_tz_mais_tempo;
/
