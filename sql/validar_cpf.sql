CREATE OR REPLACE FUNCTION validar_cpf (p_cpf IN CHAR)
RETURN VARCHAR2
IS
  v_soma  NUMBER DEFAULT 0;
  v_resto NUMBER DEFAULT 0;

BEGIN
  FOR i IN 1..9 LOOP
    v_soma := v_soma + SubStr (p_cpf, i, 1) * (11 - i);
  END LOOP;

  v_resto := 11 - Mod (v_soma, 11);

  IF (v_resto > 9) THEN
    v_resto := 0;
  END IF;

  IF (v_resto != SubStr (p_cpf, 10, 1)) THEN
    RETURN false;
  END IF;

  v_resto := 0;
  v_soma := 0;

  FOR i IN 1..10 LOOP
    v_soma := v_soma + SubStr (p_cpf, i, 1) * (12 - i);
  END LOOP;

  v_resto := 11 - Mod (v_soma, 11);

  IF (v_resto > 9) THEN
    v_resto := 0;
  END IF;

  IF (v_resto != SubStr (p_cpf, 11, 1)) THEN
    RETURN false;
  END IF;

  RETURN true;

END validar_cpf;
/
