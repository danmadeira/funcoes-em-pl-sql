CREATE OR REPLACE FUNCTION criptografar (p_valor IN VARCHAR2, p_chave IN VARCHAR2)
RETURN VARCHAR2
IS
  v_chave   RAW(32);
  v_charset VARCHAR2(8) := 'AL32UTF8';
  v_tipo    PLS_INTEGER := DBMS_CRYPTO.ENCRYPT_AES256 +
                           DBMS_CRYPTO.CHAIN_CBC +
                           DBMS_CRYPTO.PAD_PKCS5;
  
BEGIN
  v_chave := UTL_I18N.STRING_TO_RAW (
               data        => p_chave
             , dst_charset => v_charset
             );
  
  RETURN UTL_I18N.RAW_TO_CHAR (
           UTL_ENCODE.BASE64_ENCODE (
             DBMS_CRYPTO.ENCRYPT (
               src => UTL_I18N.STRING_TO_RAW (
                        data        => p_valor
                      , dst_charset => v_charset
                      )
             , typ => v_tipo
             , key => v_chave
             )
           )
         , v_charset
         );
  
EXCEPTION
  WHEN OTHERS THEN
    RETURN null;
  
END criptografar;
/

CREATE OR REPLACE FUNCTION descriptografar (p_valor IN VARCHAR2, p_chave IN VARCHAR2)
RETURN VARCHAR2  
IS
  v_chave   RAW(32);
  v_charset VARCHAR2(8) := 'AL32UTF8';
  v_tipo    PLS_INTEGER := DBMS_CRYPTO.ENCRYPT_AES256 +
                           DBMS_CRYPTO.CHAIN_CBC +
                           DBMS_CRYPTO.PAD_PKCS5;
  
BEGIN
  v_chave := UTL_I18N.STRING_TO_RAW (
               data        => p_chave
             , dst_charset => v_charset
             );
           
  RETURN UTL_I18N.RAW_TO_CHAR (
           data => DBMS_CRYPTO.DECRYPT (
                     src => UTL_ENCODE.BASE64_DECODE (
                              UTL_I18N.STRING_TO_RAW (
                                p_valor
                              , v_charset
                              )
                            )
                   , typ => v_tipo
                   , key => v_chave
                   )
         , src_charset => v_charset
         );
  
EXCEPTION
  WHEN OTHERS THEN
    RETURN null;
  
END descriptografar;
/
