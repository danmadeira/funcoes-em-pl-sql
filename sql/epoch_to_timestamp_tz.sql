CREATE OR REPLACE FUNCTION epoch_to_timestamp_tz (p_unix_epoch INTEGER)
RETURN TIMESTAMP WITH TIME ZONE
AS
  v_timezone VARCHAR2(100);
  
BEGIN
  SELECT TO_CHAR (current_timestamp, 'tzr')
    INTO v_timezone
    FROM dual;
    
  RETURN CAST (TO_TIMESTAMP_TZ ('1970-01-01T00:00:00+00:00', 'YYYY-MM-DD"T"HH24:MI:SSTZH:TZM')
               AT TIME ZONE v_timezone
               AS TIMESTAMP WITH LOCAL TIME ZONE)
       + NUMTODSINTERVAL (p_unix_epoch / 1000, 'SECOND');
  
END epoch_to_timestamp_tz;
/
