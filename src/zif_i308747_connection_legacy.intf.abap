INTERFACE zif_i308747_connection_legacy
  PUBLIC .

  TYPES: tt_connect  TYPE SORTED TABLE OF /dmo/connection  WITH UNIQUE KEY carrier_id connection_id.

  TYPES tt_if_t100_message TYPE STANDARD TABLE OF REF TO if_t100_message WITH EMPTY KEY.

  TYPES: BEGIN OF ts_connect_key,
           carrier_id    TYPE /dmo/carrier_id,
           connection_id TYPE /dmo/connection_id,
         END OF ts_connect_key.
  TYPES: tt_connect_key TYPE SORTED TABLE OF ts_connect_key WITH UNIQUE KEY carrier_id connection_id.

  TYPES: BEGIN OF ts_connect_data,
           airport_from_id TYPE /dmo/airport_from_id,
           airport_to_id   TYPE /dmo/airport_to_id,
           departure_time  TYPE /dmo/flight_departure_time,
           arrival_time    TYPE /dmo/flight_arrival_time,
           distance        TYPE /dmo/flight_distance,
           distance_unit   TYPE msehi,
         END OF ts_connect_data.

  TYPES: BEGIN OF ts_connect_in.
           INCLUDE TYPE ts_connect_key.
           INCLUDE TYPE ts_connect_data.
  TYPES: END OF ts_connect_in.

  TYPES: BEGIN OF ts_connect_intx,
           airport_from_id TYPE abap_bool,
           airport_to_id   TYPE abap_bool,
           departure_time  TYPE abap_bool,
           arrival_time    TYPE abap_bool,
           distance        TYPE abap_bool,
           distance_unit   TYPE abap_bool,
    END OF ts_connect_intx.

    TYPES BEGIN OF ts_connectx.
      INCLUDE TYPE ts_connect_key.
      TYPES action_code TYPE /dmo/action_code.
      INCLUDE TYPE ts_connect_intx.
      TYPES END OF ts_connectx.
    TYPES: tt_connectx TYPE SORTED TABLE OF ts_connectx WITH UNIQUE KEY carrier_id connection_id.

   TYPES: BEGIN OF ENUM action_code_enum STRUCTURE action_code BASE TYPE /dmo/action_code,
      initial VALUE IS INITIAL,
      create  VALUE 'C',
      update  VALUE 'U',
      delete  VALUE 'D',
    END OF ENUM action_code_enum STRUCTURE action_code.

  TYPES tt_message TYPE STANDARD TABLE OF symsg.

ENDINTERFACE.
