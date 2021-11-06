CREATE OR REPLACE FUNCTION sysdate_mais_tempo (
  p_sysdate DATE
, p_tempo   NUMBER
, p_unidade VARCHAR2
)
RETURN DATE
AS
  v_sysdate DATE;
  
BEGIN
  SELECT CASE
           WHEN (p_unidade = 'D') THEN
             p_sysdate + p_tempo                  -- mais n dias
           WHEN (p_unidade = 'H') THEN
             p_sysdate + p_tempo / 24             -- mais n horas
           WHEN (p_unidade = 'M') THEN
             p_sysdate + p_tempo / (24 * 60)      -- mais n minutos
           WHEN (p_unidade = 'S') THEN
             p_sysdate + p_tempo / (24 * 60 * 60) -- mais n segundos
         END AS tempo
    INTO v_sysdate
    FROM dual;

  RETURN v_sysdate;
  
END sysdate_mais_tempo;
/
