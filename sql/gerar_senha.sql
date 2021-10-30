CREATE OR REPLACE FUNCTION gerar_senha (
  p_alp IN PLS_INTEGER DEFAULT 5,
  p_num IN PLS_INTEGER DEFAULT 2,
  p_spc IN PLS_INTEGER DEFAULT 1
)
RETURN VARCHAR2
IS
  v_alp VARCHAR2(47) := 'abcdefhijkmnoprstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ';
  v_num VARCHAR2(8)  := '23456789';
  v_spc VARCHAR2(17) := '!$%&/()=?+*#-@:<>';
  v_pwd VARCHAR2(60) := '';
  v_sel VARCHAR2(60) := '';
  
BEGIN
  IF (p_alp NOT BETWEEN 0 AND 20) OR
     (p_num NOT BETWEEN 0 AND 20) OR
     (p_spc NOT BETWEEN 0 AND 20) THEN
    RAISE value_error;
  END IF;
  
  v_sel := v_sel || rpad ('a', p_alp, 'a');
  v_sel := v_sel || rpad ('n', p_num, 'n');
  v_sel := v_sel || rpad ('s', p_spc, 's');
  
  FOR rec IN (SELECT level
                FROM dual
             CONNECT BY level <= length(v_sel)
               ORDER BY DBMS_RANDOM.value())
  LOOP
    CASE substr (v_sel, rec.level, 1)
      WHEN 'a' THEN
        v_pwd := v_pwd || substr (v_alp, DBMS_RANDOM.value(1, length(v_alp)), 1);
      WHEN 'n' THEN
        v_pwd := v_pwd || substr (v_num, DBMS_RANDOM.value(1, length(v_num)), 1);
      WHEN 's' THEN
        v_pwd := v_pwd || substr (v_spc, DBMS_RANDOM.value(1, length(v_spc)), 1);
      ELSE
        NULL;
    END CASE;
  END LOOP;
  
  RETURN v_pwd;
  
EXCEPTION
  WHEN OTHERS THEN
    RETURN null;
  
END gerar_senha;
/
