class ZCL_I308747_CONNECTION_LEGACY definition
  public
  final
  create private .

public section.

  interfaces ZIF_I308747_CONNECTION_LEGACY .

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to ZCL_I308747_CONNECTION_LEGACY .
  methods CREATE_CONNECT
    importing
      !IS_CONNECT type ZIF_I308747_CONNECTION_LEGACY=>TS_CONNECT_IN
    exporting
      !ES_CONNECT type /DMO/CONNECTION
      !ET_MESSAGES type ZIF_I308747_CONNECTION_LEGACY=>TT_IF_T100_MESSAGE .
  methods SAVE .
  methods SUSPEND
    importing
      !IV_CARRIERID type /DMO/CARRIER_ID
      !IV_CONNECTIONID type /DMO/CONNECTION_ID
    exporting
      !ET_MESSAGES type ZIF_I308747_CONNECTION_LEGACY=>TT_IF_T100_MESSAGE .
protected section.
private section.

  class-data GO_INSTANCE type ref to ZCL_I308747_CONNECTION_LEGACY .
ENDCLASS.



CLASS ZCL_I308747_CONNECTION_LEGACY IMPLEMENTATION.


  METHOD create_connect.
    CLEAR: es_connect,et_messages.

    " Connection
    lcl_connect_buffer=>get_instance( )->cud_prep( EXPORTING it_connect   = VALUE #( ( CORRESPONDING #( is_connect ) ) )
                                                            it_connectx  = VALUE #( ( carrier_id = is_connect-carrier_id
                                                                               connection_id = is_connect-connection_id
                                                                               action_code = /dmo/if_flight_legacy=>action_code-create ) )
                                                  IMPORTING et_connect   = DATA(lt_connect)
                                                            et_messages = et_messages ).
    IF et_messages IS INITIAL.
      ASSERT lines( lt_connect ) = 1.
      es_connect = lt_connect[ 1 ].
      lcl_connect_buffer=>get_instance( )->cud_copy( ).
    ELSE.
      CLEAR: es_connect.
      lcl_connect_buffer=>get_instance( )->cud_disc( ).
    ENDIF.
  ENDMETHOD.


  method GET_INSTANCE.
    go_instance = COND #( WHEN go_instance IS BOUND THEN go_instance ELSE NEW #( ) ).
    ro_instance = go_instance.
  endmethod.


  METHOD save.
    lcl_connect_buffer=>get_instance( )->save( ).
  ENDMETHOD.


  METHOD suspend.
    lcl_connect_buffer=>get_instance( )->suspend( EXPORTING iv_carrierid = iv_carrierid
                                                            iv_connectionid = iv_connectionid
                                                  IMPORTING et_messages  = et_messages ).
  ENDMETHOD.
ENDCLASS.
