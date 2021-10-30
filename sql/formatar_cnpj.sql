CREATE OR REPLACE FUNCTION formatar_cnpj (p_cnpj IN VARCHAR2)
RETURN VARCHAR2
IS
BEGIN
  RETURN regexp_replace (LPAD (p_cnpj, 14), '([0-9]{2})([0-9]{3})([0-9]{3})([0-9]{4})', '\1.\2.\3/\4-');
END formatar_cnpj;
/
