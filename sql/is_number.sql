CREATE OR REPLACE FUNCTION is_number (p_string IN VARCHAR2)
RETURN BOOLEAN
IS
  v_num NUMBER;
  
BEGIN
  v_num := TO_NUMBER(p_string);
  RETURN true;
  
EXCEPTION
  WHEN VALUE_ERROR THEN
    RETURN false;
END is_number;
/
