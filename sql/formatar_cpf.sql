CREATE OR REPLACE FUNCTION formatar_cpf (p_cpf IN VARCHAR2)
RETURN VARCHAR2
IS
BEGIN
  RETURN regexp_replace (LPAD (p_cpf, 11), '([0-9]{3})([0-9]{3})([0-9]{3})', '\1.\2.\3-');
END formatar_cpf;
/
