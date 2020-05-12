class ZCL_AU_I308747_SC_ROOT_D_TP definition
  public
  inheriting from /BOBF/CL_LIB_AUTH_DRAFT_ACTIVE
  final
  create public .

public section.

  interfaces /BOBF/IF_FRW_VALIDATION .

  methods /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_INSTANCE_AUTHORITY
    redefinition .
  methods /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_STATIC_AUTHORITY
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_AU_I308747_SC_ROOT_D_TP IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.
    DATA lt_scart       TYPE zti308747_sc_root_d_tp.
  DATA ls_key TYPE /bobf/s_frw_key.
  DATA lv_count TYPE i.

  READ TABLE it_key INTO ls_key INDEX 1.

  io_read->retrieve(
    EXPORTING
      iv_node                 = is_ctx-node_key
      it_key                  = it_key
      iv_fill_data            = abap_true
    IMPORTING
      eo_message              = eo_message
      et_data                 = lt_scart
      et_failed_key           = et_failed_key ).

  READ TABLE lt_scart ASSIGNING FIELD-SYMBOL(<fs_scart>) INDEX 1.

  IF <fs_scart>-waers IS INITIAL.
    eo_message = /bobf/cl_frw_factory=>get_message( ).
    eo_message->add_message(
      EXPORTING
          is_msg  = VALUE #( msgid = 'ZI308747'
                             msgno = 0
                             msgty = /bobf/cm_frw=>co_severity_error )
          iv_node = is_ctx-node_key
          iv_key  = <fs_scart>-key
          iv_attribute = zif_i308747_sc_root_D_tp_c=>sc_node_attribute-zi308747_sc_root_D_tp-waers ).

    APPEND VALUE #( key = <fs_scart>-key ) TO et_failed_key.
  ENDIF.

  SELECT COUNT(*) FROM zi308747_sc_root
    INTO @lv_count
    WHERE cart_id = @<fs_scart>-cart_id.

  IF lv_count > 0. "Shopping Cart ID must be unique
    eo_message = /bobf/cl_frw_factory=>get_message( ).
    eo_message->add_message(
      EXPORTING
        is_msg  = VALUE #( msgid = 'ZI308747'
                           msgno = 1
                           msgty = /bobf/cm_frw=>co_severity_error )
        iv_node = is_ctx-node_key
        iv_key  = <fs_scart>-key
        iv_attribute = zif_i308747_sc_root_D_tp_c=>sc_node_attribute-zi308747_sc_root_D_tp-cart_id ).

    APPEND VALUE #( key = <fs_scart>-key ) TO et_failed_key.
  ENDIF.
  ENDMETHOD.


  method /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_INSTANCE_AUTHORITY.
  endmethod.


  method /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_STATIC_AUTHORITY.
  endmethod.
ENDCLASS.
