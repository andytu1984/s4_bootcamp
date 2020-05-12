CLASS lhc_connect DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE connect.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE connect.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE connect.

    METHODS read FOR READ
      IMPORTING keys FOR READ connect RESULT result.

    METHODS suspend FOR MODIFY
      IMPORTING keys FOR ACTION connect~suspend RESULT result.

ENDCLASS.

CLASS lhc_connect IMPLEMENTATION.

  METHOD create.
  DATA lt_messages   TYPE /dmo/if_flight_legacy=>tt_message.
    DATA ls_connect_in  TYPE /dmo/connection.
    DATA ls_connect_out TYPE /dmo/connection.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_connect_create>).

      ls_connect_in = CORRESPONDING #( <fs_connect_create> MAPPING FROM ENTITY USING CONTROL ).

    CALL FUNCTION 'ZI308747_CONNECTION_CREATE'
        EXPORTING
          is_connect   = CORRESPONDING zif_i308747_connection_legacy=>ts_connect_in( ls_connect_in )
        IMPORTING
          es_connect   = ls_connect_out
          et_messages = lt_messages
.

    if lt_messages is INITIAL.
      INSERT VALUE #( %cid = <fs_connect_create>-%cid  AirlineId = ls_connect_out-carrier_Id
                       ConnectionId = ls_connect_out-connection_id )
                       INTO TABLE mapped-connect.
    endif.

    ENDLOOP.

  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD suspend.
    DATA lt_messages TYPE zif_i308747_connection_legacy=>tt_message.
    DATA ls_connect_out TYPE /dmo/connection.

    clear result.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_connect_suspend>).
      DATA(lv_carrierid) = <fs_connect_suspend>-AirlineId.
      data(lv_connectionid) = <fs_connect_suspend>-ConnectionId.

      IF lv_carrierid IS INITIAL OR lv_carrierid = ''.
        lv_carrierid = mapped-connect[ %cid = <fs_connect_suspend>-%cid_ref ]-airlineid.
      ENDIF.
      IF lv_connectionid IS INITIAL OR lv_connectionid = ''.
        lv_connectionid = mapped-connect[ %cid = <fs_connect_suspend>-%cid_ref ]-ConnectionId.
      ENDIF.


      CALL FUNCTION 'ZI308747_CONNECTION_SUSPEND'
        EXPORTING
          iv_carrierid = lv_carrierid
          iv_connectionid = lv_connectionid
        IMPORTING
          et_messages  = lt_messages.

       IF lt_messages IS INITIAL.
        APPEND VALUE #( airlineid        = lv_carrierid
                        connectionid = lv_connectionid
                        %param-airlineid = lv_carrierid
                        %param-connectionid = lv_connectionid )
               TO result.
      ELSE.

*        zcl_travel_auxiliary_xx=>handle_travel_messages(
*          EXPORTING
*            iv_cid       = <fs_travel_set_status_booked>-%cid_ref
*            iv_travel_id = lv_travelid
*            it_messages  = lt_messages
*          CHANGING
*            failed       = failed-travel
*            reported     = reported-travel
*        ).

       ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI308747_CONNECT DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS check_before_save REDEFINITION.

    METHODS finalize          REDEFINITION.

    METHODS save              REDEFINITION.

ENDCLASS.

CLASS lsc_ZI308747_CONNECT IMPLEMENTATION.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD finalize.
  ENDMETHOD.

  METHOD save.
  CALL FUNCTION 'ZI308747_CONNECTION_SAVE'.
  ENDMETHOD.

ENDCLASS.
