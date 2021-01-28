CLASS lhc_Customer DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS CalculateCustomerID FOR DETERMINE ON SAVE
      IMPORTING keys FOR Customer~calculateCustomerID.
    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Customer~validateCustomer.

ENDCLASS.

CLASS lhc_customer IMPLEMENTATION.

  " Method for adding a random customer ID to a newly created customer
  METHOD CalculateCustomerID.
    " Check if customer Id is already filled
    READ ENTITIES OF zi_customer_918 IN LOCAL MODE
      ENTITY Customer
        FIELDS ( Id ) WITH CORRESPONDING #( keys )
      RESULT DATA(customers).


    DELETE customers WHERE Id IS NOT INITIAL.
    CHECK customers IS NOT INITIAL.


    DATA: randomCustomerId TYPE string.
    DATA(o_rand_i) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( ) min = 10000000 max = 99999999 ).
    randomCustomerId = o_rand_i->get_next( ).

    " Set the new customer ID
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

  " Method that validates all values related to the customer.
  " If a value is missing the related error message is displayed.
  METHOD validateCustomer.
    READ ENTITY zi_customer_918\\Customer FROM VALUE #(
        FOR <root_key> IN keys ( %key-CustomerUUID     = <root_key>-CustomerUUID
                                 %control = VALUE #( FirstName = if_abap_behv=>mk-on
                                                     LastName   = if_abap_behv=>mk-on
                                                     Street = if_abap_behv=>mk-on
                                                     City = if_abap_behv=>mk-on
                                                     Postcode = if_abap_behv=>mk-on ) ) )
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

      IF ls_customer_result-Street = ''.
        APPEND VALUE #( %key        = ls_customer_result-%key
                        CustomerUUID   = ls_customer_result-CustomerUUID ) TO failed-customer.

        APPEND VALUE #( %key     = ls_customer_result-%key
                        %msg     = new_message( id       = 'Z_MSG_918'
                                                number   = '007'
                                                v1       = ls_customer_result-Street
                                                severity = if_abap_behv_message=>severity-error )
                        %element-Street = if_abap_behv=>mk-on ) TO reported-customer.
      ENDIF.

      IF ls_customer_result-City = ''.
        APPEND VALUE #( %key        = ls_customer_result-%key
                        CustomerUUID   = ls_customer_result-CustomerUUID ) TO failed-customer.

        APPEND VALUE #( %key     = ls_customer_result-%key
                        %msg     = new_message( id       = 'Z_MSG_918'
                                                number   = '008'
                                                v1       = ls_customer_result-City
                                                severity = if_abap_behv_message=>severity-error )
                        %element-City = if_abap_behv=>mk-on ) TO reported-customer.
      ENDIF.

      IF ls_customer_result-Postcode = ''.
        APPEND VALUE #( %key        = ls_customer_result-%key
                        CustomerUUID   = ls_customer_result-CustomerUUID ) TO failed-customer.

        APPEND VALUE #( %key     = ls_customer_result-%key
                        %msg     = new_message( id       = 'Z_MSG_918'
                                                number   = '009'
                                                v1       = ls_customer_result-Postcode
                                                severity = if_abap_behv_message=>severity-error )
                        %element-Postcode = if_abap_behv=>mk-on ) TO reported-customer.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
