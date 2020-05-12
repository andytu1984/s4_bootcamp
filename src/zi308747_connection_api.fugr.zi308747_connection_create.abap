"! <h1>API for Creating a Travel</h1>
"!
"! <p>
"! Function module to create a single Travel instance with the possibility to create related Bookings and
"! Booking Supplements in the same call (so called deep-create).
"! </p>
"!
"! <p>
"! The <em>travel_id</em> will be provided be the API but the IDs of Booking <em>booking_id</em> as well
"! of Booking Supplements <em>booking_id</em> and <em>booking_supplement_id</em>.
"! </p>
"!
"!
"! @parameter is_travel             | Travel Data
"! @parameter it_booking            | Table of predefined Booking Key <em>booking_id</em> and Booking Data
"! @parameter it_booking_supplement | Table of predefined Booking Supplement Key <em>booking_id</em>, <em>booking_supplement_id</em> and Booking Supplement Data
"! @parameter es_travel             | Evaluated Travel Data like /DMO/TRAVEL
"! @parameter et_booking            | Table of evaluated Bookings like /DMO/BOOKING
"! @parameter et_booking_supplement | Table of evaluated Booking Supplements like /DMO/BOOK_SUPPL
"! @parameter et_messages           | Table of occurred messages
"!
FUNCTION zi308747_connection_create.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IS_CONNECT) TYPE
*"        ZIF_I308747_CONNECTION_LEGACY=>TS_CONNECT_IN
*"  EXPORTING
*"     REFERENCE(ES_CONNECT) TYPE  /DMO/CONNECTION
*"----------------------------------------------------------------------
  CLEAR es_connect.

  zcl_i308747_connection_legacy=>get_instance( )->create_connect( EXPORTING is_connect             = is_connect
                                                                  IMPORTING es_connect            = es_connect
                                                                            et_messages           = DATA(lt_messages) ).
ENDFUNCTION.
