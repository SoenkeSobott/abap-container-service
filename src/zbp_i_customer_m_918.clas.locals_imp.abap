CLASS lhc_Customer DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF order_status,
        Open    TYPE string  VALUE 'Open', " Open
        On_Site TYPE string  VALUE 'On-Site', " On-Site
        Closed  TYPE string VALUE 'Closed', " Closed
      END OF order_status.

    METHODS CalculateCustomerID FOR DETERMINE ON SAVE
      IMPORTING keys FOR Customer~calculateCustomerID.
    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Customer~validateCustomer.

ENDCLASS.

CLASS lhc_customer IMPLEMENTATION.

  " Method for adding a random customerId to a new created customer
  METHOD CalculateCustomerID.
    " check if Id is already filled
    READ ENTITIES OF zi_customer_918 IN LOCAL MODE
      ENTITY Customer
        FIELDS ( Id ) WITH CORRESPONDING #( keys )
      RESULT DATA(customers).


    DELETE customers WHERE Id IS NOT INITIAL.
    CHECK customers IS NOT INITIAL.


    DATA: randomCustomerId TYPE string.
    DATA(o_rand_i) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( ) min = 10000000 max = 99999999 ).
    randomCustomerId = o_rand_i->get_next( ).

    " Set the customer ID
    MODIFY ENTITIES OF zi_customer_918 IN LOCAL MODE
    ENTITY Customer
      UPDATE
        FROM VALUE #( FOR customer IN customers INDEX INTO i (
          %tky              = customer-%tky
          Id          = randomcustomerid
          %control-Id = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD validateCustomer.
    READ ENTITY zi_customer_918\\Customer FROM VALUE #(
        FOR <root_key> IN keys ( %key-CustomerUUID     = <root_key>-CustomerUUID
                                 %control = VALUE #( FirstName = if_abap_behv=>mk-on
                                                     LastName   = if_abap_behv=>mk-on
                                                     Address = if_abap_behv=>mk-on ) ) )
        RESULT DATA(lt_customer_result).

    LOOP AT lt_customer_result INTO DATA(ls_customer_result).

      IF ls_customer_result-FirstName = ''.
        APPEND VALUE #( %key        = ls_customer_result-%key
                        CustomerUUID   = ls_customer_result-CustomerUUID ) TO failed-customer.

        APPEND VALUE #( %key     = ls_customer_result-%key
                        %msg     = new_message( id       = 'Z_MSG_918'
                                                number   = '005'
                                                v1       = ls_customer_result-FirstName
                                                severity = if_abap_behv_message=>severity-error )
                        %element-FirstName = if_abap_behv=>mk-on ) TO reported-customer.
      ENDIF.

      IF ls_customer_result-LastName = ''.
        APPEND VALUE #( %key        = ls_customer_result-%key
                        CustomerUUID   = ls_customer_result-CustomerUUID ) TO failed-customer.

        APPEND VALUE #( %key     = ls_customer_result-%key
                        %msg     = new_message( id       = 'Z_MSG_918'
                                                number   = '006'
                                                v1       = ls_customer_result-LastName
                                                severity = if_abap_behv_message=>severity-error )
                        %element-LastName = if_abap_behv=>mk-on ) TO reported-customer.
      ENDIF.

      IF ls_customer_result-Address = ''.
        APPEND VALUE #( %key        = ls_customer_result-%key
                        CustomerUUID   = ls_customer_result-CustomerUUID ) TO failed-customer.

        APPEND VALUE #( %key     = ls_customer_result-%key
                        %msg     = new_message( id       = 'Z_MSG_918'
                                                number   = '007'
                                                v1       = ls_customer_result-Address
                                                severity = if_abap_behv_message=>severity-error )
                        %element-Address = if_abap_behv=>mk-on ) TO reported-customer.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
