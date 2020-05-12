FUNCTION zi308747_connection_suspend.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRIERID) TYPE  /DMO/CARRIER_ID
*"     REFERENCE(IV_CONNECTIONID) TYPE  /DMO/CONNECTION_ID
*"  EXPORTING
*"     REFERENCE(ET_MESSAGES) TYPE
*"        ZIF_I308747_CONNECTION_LEGACY=>TT_MESSAGE
*"----------------------------------------------------------------------

CLEAR et_messages.

  zcl_i308747_connection_legacy=>get_instance( )->suspend( EXPORTING iv_carrierid = iv_carrierid
                                                                   iv_connectionid = iv_connectionid
                                                         IMPORTING et_messages  = DATA(lt_messages) ).



ENDFUNCTION.
