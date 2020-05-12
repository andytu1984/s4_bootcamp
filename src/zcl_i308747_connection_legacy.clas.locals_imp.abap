CLASS lcl_connect_buffer DEFINITION FINAL CREATE PRIVATE.
  PUBLIC SECTION.

    CLASS-METHODS: get_instance RETURNING VALUE(ro_instance) TYPE REF TO lcl_connect_buffer.

    METHODS save.
    METHODS initialize.
    METHODS cud_prep IMPORTING it_connect          TYPE zif_i308747_connection_legacy=>tt_connect
                               it_connectx         TYPE zif_i308747_connection_legacy=>tt_connectx
                     EXPORTING et_connect          TYPE zif_i308747_connection_legacy=>tt_connect
                               et_messages        TYPE zif_i308747_connection_legacy=>tt_if_t100_message.
    "! Add content of the temporary buffer to the real buffer and clear the temporary buffer
    METHODS cud_copy.
    "! Discard content of the temporary buffer
    METHODS cud_disc.

    METHODS suspend IMPORTING iv_carrierid TYPE /dmo/carrier_id
                              iv_connectionid TYPE /dmo/connection_id
                    EXPORTING et_messages  TYPE zif_i308747_connection_legacy=>tt_if_t100_message.

PRIVATE SECTION.
    CLASS-DATA go_instance TYPE REF TO lcl_connect_buffer.
    " Main buffer
    DATA: mt_create_buffer TYPE zif_i308747_connection_legacy=>tt_connect,
          mt_update_buffer TYPE zif_i308747_connection_legacy=>tt_connect,
          mt_delete_buffer TYPE zif_i308747_connection_legacy=>tt_connect_key.
    " Temporary buffer valid during create / update / delete Travel
    DATA: mt_create_buffer_2 TYPE zif_i308747_connection_legacy=>tt_connect,
          mt_update_buffer_2 TYPE zif_i308747_connection_legacy=>tt_connect,
          mt_delete_buffer_2 TYPE zif_i308747_connection_legacy=>tt_connect_key.

    METHODS _create IMPORTING it_connect   TYPE zif_i308747_connection_legacy=>tt_connect
                    EXPORTING et_connect   TYPE zif_i308747_connection_legacy=>tt_connect
                              et_messages TYPE zif_i308747_connection_legacy=>tt_if_t100_message.


ENDCLASS.

CLASS lcl_connect_buffer IMPLEMENTATION.

  METHOD get_instance.
    go_instance = COND #( WHEN go_instance IS BOUND THEN go_instance ELSE NEW #( ) ).
    ro_instance = go_instance.
  ENDMETHOD.

  METHOD initialize.
    CLEAR: mt_create_buffer, mt_update_buffer, mt_delete_buffer.
  ENDMETHOD.

  METHOD _create.
    CLEAR et_connect.
    CLEAR et_messages.

    CHECK it_connect IS NOT INITIAL.

    LOOP AT it_connect INTO DATA(ls_connect_create) ##INTO_OK.

      INSERT ls_connect_create INTO TABLE mt_create_buffer_2.
    ENDLOOP.

    et_connect = mt_create_buffer_2.
  ENDMETHOD.

  METHOD cud_disc.
    CLEAR: mt_create_buffer_2, mt_update_buffer_2, mt_delete_buffer_2.
  ENDMETHOD.

  METHOD cud_prep.
    CLEAR et_connect.
    CLEAR et_messages.

    CHECK it_connect IS NOT INITIAL.

    DATA lt_connect_c  TYPE zif_i308747_connection_legacy=>tt_connect.
    DATA lt_connect_u  TYPE zif_i308747_connection_legacy=>tt_connect.
    DATA lt_connect_d  TYPE zif_i308747_connection_legacy=>tt_connect.
    DATA lt_connectx_u TYPE zif_i308747_connection_legacy=>tt_connectx.
    LOOP AT it_connect ASSIGNING FIELD-SYMBOL(<fs_connect>).
      READ TABLE it_connectx ASSIGNING FIELD-SYMBOL(<fs_connectx>) WITH TABLE KEY carrier_id = <fs_connect>-carrier_id
                                                                   connection_id = <fs_connect>-connection_id.
      IF sy-subrc <> 0.
*        APPEND NEW /dmo/cx_flight_legacy( textid     = /dmo/cx_flight_legacy=>travel_no_control
*                                          travel_id  = <s_travel>-travel_id ) TO et_messages.
        RETURN.
      ENDIF.
      CASE CONV zif_i308747_connection_legacy=>action_code_enum( <fs_connectx>-action_code ).
        WHEN zif_i308747_connection_legacy=>action_code-create.
          INSERT <fs_connect>  INTO TABLE lt_connect_c.
        WHEN zif_i308747_connection_legacy=>action_code-update.
          INSERT <fs_connect>  INTO TABLE lt_connect_u.
          INSERT <fs_connectx>  INTO TABLE lt_connectx_u.
        WHEN zif_i308747_connection_legacy=>action_code-delete.
          INSERT <fs_connect>  INTO TABLE lt_connect_d.
      ENDCASE.
    ENDLOOP.

    _create( EXPORTING it_connect   = lt_connect_c
             IMPORTING et_connect   = et_connect
                       et_messages = et_messages ).

*    _update( EXPORTING it_connect   = lt_travel_u
*                       it_connectx  = lt_connectx_u
*             IMPORTING et_connect   = DATA(lt_connect)
*                       et_messages = DATA(lt_messages) ).
*    INSERT LINES OF lt_connect INTO TABLE et_connect.
*    APPEND LINES OF lt_messages TO et_messages.
*
*    _delete( EXPORTING it_connect          = lt_connect_d
*                       iv_no_delete_check = iv_no_delete_check
*             IMPORTING et_messages        = lt_messages ).
*    APPEND LINES OF lt_messages TO et_messages.
  ENDMETHOD.


  METHOD cud_copy.
    LOOP AT mt_create_buffer_2 ASSIGNING FIELD-SYMBOL(<s_create_buffer_2>).
      READ TABLE mt_create_buffer ASSIGNING FIELD-SYMBOL(<s_create_buffer>)
      WITH TABLE KEY carrier_id = <s_create_buffer_2>-carrier_id
                     connection_id = <s_create_buffer_2>-connection_id.

      IF sy-subrc <> 0.
        INSERT VALUE #( carrier_id = <s_create_buffer_2>-carrier_id  connection_id = <s_create_buffer_2>-connection_id ) INTO TABLE mt_create_buffer ASSIGNING <s_create_buffer>.
      ENDIF.
    ENDLOOP.

    LOOP AT mt_update_buffer_2 ASSIGNING FIELD-SYMBOL(<s_update_buffer_2>).
      READ TABLE mt_update_buffer ASSIGNING FIELD-SYMBOL(<s_update_buffer>)
      WITH TABLE KEY carrier_id = <s_update_buffer_2>-carrier_id
                     connection_id = <s_update_buffer_2>-connection_id.
      IF sy-subrc <> 0.
        INSERT VALUE #( carrier_id = <s_update_buffer_2>-carrier_id  connection_id = <s_update_buffer_2>-connection_id ) INTO TABLE mt_update_buffer ASSIGNING <s_update_buffer>.
      ENDIF.
    ENDLOOP.

    LOOP AT mt_delete_buffer_2 ASSIGNING FIELD-SYMBOL(<s_delete_buffer_2>).
      DELETE mt_create_buffer WHERE carrier_id = <s_delete_buffer_2>-carrier_id AND connection_id = <s_delete_buffer_2>-connection_id.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.

      DELETE mt_update_buffer WHERE carrier_id = <s_delete_buffer_2>-carrier_id AND connection_id = <s_delete_buffer_2>-connection_id.
      INSERT <s_delete_buffer_2> INTO TABLE mt_delete_buffer.
    ENDLOOP.
    CLEAR: mt_create_buffer_2, mt_update_buffer_2, mt_delete_buffer_2.
  ENDMETHOD.

  METHOD suspend.
    DATA lv_new TYPE abap_bool.

    CLEAR et_messages.

    " Check for empty travel ID
    IF iv_carrierid IS INITIAL OR iv_connectionid IS INITIAL.
*      APPEND NEW /dmo/cx_flight_legacy( textid = /dmo/cx_flight_legacy=>travel_no_key ) TO et_messages.
      RETURN.
    ENDIF.

    READ TABLE mt_delete_buffer TRANSPORTING NO FIELDS
                                WITH TABLE KEY carrier_id = iv_carrierid
                                connection_id = iv_connectionid.
    IF sy-subrc = 0." Error: Record of action marked for deletion
*      APPEND NEW /dmo/cx_flight_legacy( textid = /dmo/cx_flight_legacy=>travel_unknown  travel_id = iv_travel_id ) TO et_messages.
      RETURN.
    ENDIF.

    " Special case: Record in CREATE buffer
    lv_new = abap_false.
    READ TABLE mt_create_buffer ASSIGNING FIELD-SYMBOL(<s_connect>)
                                WITH TABLE KEY carrier_id = iv_carrierid
                                connection_id = iv_connectionid.
    IF sy-subrc = 0.
      lv_new = abap_true.
    ENDIF.

    " Special case: Record in UPDATE buffer
    IF <s_connect> IS NOT ASSIGNED.
      READ TABLE mt_update_buffer ASSIGNING <s_connect>
      WITH TABLE KEY carrier_id = iv_carrierid
                                connection_id = iv_connectionid.
    ENDIF.

    " Usual case: Read record from DB and put it into the UPDATE buffer
    IF <s_connect> IS NOT ASSIGNED.
      SELECT SINGLE * FROM /dmo/connection WHERE carrier_id = @iv_carrierid AND connection_id = @iv_connectionid
        INTO @DATA(ls_connect) .
      IF sy-subrc = 0.
        INSERT ls_connect INTO TABLE mt_update_buffer ASSIGNING <s_connect>.
      ENDIF.
    ENDIF.

    " Error
    IF <s_connect> IS NOT ASSIGNED.
*      APPEND NEW /dmo/cx_flight_legacy( textid = /dmo/cx_flight_legacy=>travel_unknown  travel_id = iv_travel_id ) TO et_messages.
      RETURN.
    ENDIF.

    CLEAR: <s_connect>-departure_time,<s_connect>-arrival_time.
*    _update_admin( EXPORTING iv_new = lv_new CHANGING cs_travel_admin = <s_travel>-gr_admin ).
  ENDMETHOD.

  METHOD save.
    ASSERT mt_create_buffer_2 IS INITIAL.
    ASSERT mt_update_buffer_2 IS INITIAL.
    ASSERT mt_delete_buffer_2 IS INITIAL.
    INSERT /dmo/connection FROM TABLE @mt_create_buffer.
    UPDATE /dmo/connection FROM TABLE @mt_update_buffer.
    DELETE /dmo/connection FROM TABLE @( CORRESPONDING #( mt_delete_buffer ) ).
  ENDMETHOD.

ENDCLASS.
