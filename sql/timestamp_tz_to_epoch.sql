CREATE OR REPLACE FUNCTION timestamp_tz_to_epoch (p_timestamp TIMESTAMP WITH TIME ZONE)
RETURN INTEGER
AS
  v_epoch INTEGER;
  
BEGIN
  SELECT trunc (
                (
                 extract (day    FROM (p_timestamp - timestamp '1970-01-01 00:00:00 +00:00')) * 86400 +
                 extract (hour   FROM (p_timestamp - timestamp '1970-01-01 00:00:00 +00:00')) * 3600 +
                 extract (minute FROM (p_timestamp - timestamp '1970-01-01 00:00:00 +00:00')) * 60 +
                 extract (second FROM (p_timestamp - timestamp '1970-01-01 00:00:00 +00:00'))
                ) * 1000
               )
    INTO v_epoch
    FROM dual;
    
  RETURN v_epoch;
  
END timestamp_tz_to_epoch;
/
