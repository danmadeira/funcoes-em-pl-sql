CREATE OR REPLACE FUNCTION blob_to_clob (p_blob IN BLOB)
RETURN CLOB
AS
  v_clob    CLOB;
  v_varchar VARCHAR2(32767);
  v_start   PLS_INTEGER := 1;
  v_buffer  PLS_INTEGER := 32767;

BEGIN
  DBMS_LOB.CREATETEMPORARY (v_clob, TRUE);
  
  FOR i IN 1..CEIL (DBMS_LOB.GETLENGTH (p_blob) / v_buffer)
  LOOP
    v_varchar := UTL_RAW.CAST_TO_VARCHAR2 (DBMS_LOB.SUBSTR (p_blob, v_buffer, v_start));
    DBMS_LOB.WRITEAPPEND (v_clob, LENGTH (v_varchar), v_varchar);
    v_start := v_start + v_buffer;
  END LOOP;
  
  RETURN v_clob;
  
END blob_to_clob;
/
