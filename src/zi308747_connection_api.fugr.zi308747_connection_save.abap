"! API for Saving the Transactional Buffer of the Travel API
"!
FUNCTION zi308747_connection_save.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"----------------------------------------------------------------------
  zcl_i308747_connection_legacy=>get_instance( )->save( ).
ENDFUNCTION.
