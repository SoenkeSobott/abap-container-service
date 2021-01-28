CLASS lsc_zi_order_918_1 DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS map_messages REDEFINITION.

ENDCLASS.

CLASS lsc_zi_order_918_1 IMPLEMENTATION.

  METHOD map_messages.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_order DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF order_status,
        Open    TYPE string  VALUE 'Open', " Open
        On_Site TYPE string  VALUE 'On-Site', " On-Site
        Closed  TYPE string VALUE 'Closed', " Closed
      END OF order_status.

    METHODS calculateOrderID FOR DETERMINE ON SAVE
      IMPORTING keys FOR Order~calculateOrderID.

    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Order~setInitialStatus.

    METHODS validateOrder FOR VALIDATE ON SAVE
      IMPORTING keys FOR Order~validateOrder.

    METHODS deliverOrder FOR MODIFY
      IMPORTING keys FOR ACTION Order~deliverOrder RESULT result.

    METHODS closeOrder FOR MODIFY
      IMPORTING keys FOR ACTION Order~closeOrder RESULT result.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Order~validateCustomer.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Order RESULT result.

ENDCLASS.

CLASS lhc_order IMPLEMENTATION.

  " Method for adding a random orderId to a newly created order
  METHOD CalculateOrderID.
    " check if Id is already filled
    READ ENTITIES OF ZI_ORDER_918_1 IN LOCAL MODE
      ENTITY Order
        FIELDS ( Id ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).


    DELETE orders WHERE Id IS NOT INITIAL.
    CHECK orders IS NOT INITIAL.

    " Generate random number as order id
    DATA: randomOrderId TYPE string.
    DATA(o_rand_i) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( ) min = 10000000 max = 99999999 ).
    randomOrderId = o_rand_i->get_next( ).

    " Set the ID
    MODIFY ENTITIES OF ZI_ORDER_918_1 IN LOCAL MODE
    ENTITY Order
      UPDATE
        FROM VALUE #( FOR order IN orders INDEX INTO i (
          %tky              = order-%tky
          Id          = randomorderid
          %control-Id = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.


  " Sets the initial status of an order if no user input is given
  " Default status is 'Open'
  METHOD setInitialStatus.
    " Read relevant instance data
    READ ENTITIES OF ZI_ORDER_918_1 IN LOCAL MODE
      ENTITY Order
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    " Remove all instance data with defined status
    DELETE orders WHERE Status IS NOT INITIAL.
    CHECK orders IS NOT INITIAL.

    " Set default order status
    MODIFY ENTITIES OF ZI_ORDER_918_1 IN LOCAL MODE
    ENTITY Order
      UPDATE
        FIELDS ( Status )
        WITH VALUE #( FOR order IN orders
                      ( %tky         = order-%tky
                        Status = order_status-open ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  " Validate all order related fields.
  " If an field is invalid the related error message is returned.
  METHOD validateOrder.
    READ ENTITY ZI_ORDER_918_1\\Order FROM VALUE #(
        FOR <root_key> IN keys ( %key-OrderUUID     = <root_key>-OrderUUID
                                 %control = VALUE #( DeliveryDate = if_abap_behv=>mk-on
                                                     PickUpDate   = if_abap_behv=>mk-on ) ) )
        RESULT DATA(lt_order_result).

    LOOP AT lt_order_result INTO DATA(ls_order_result).

      " Check if status is valid
      IF ls_order_result-Status <> 'Open' AND ls_order_result-Status <> 'On-Site' AND ls_order_result-Status <> 'Closed'.
        APPEND VALUE #( %key        = ls_order_result-%key
                        OrderUUID   = ls_order_result-OrderUUID ) TO failed-order.

        APPEND VALUE #( %key     = ls_order_result-%key
                        %msg     = new_message( id       = 'Z_MSG_918'
                                                number   = '003'
                                                v1       = ls_order_result-Status
                                                severity = if_abap_behv_message=>severity-error )
                        %element-status = if_abap_behv=>mk-on ) TO reported-order.
      ENDIF.

      " Check that DeliveryDate is before PickUpDate
      IF ls_order_result-PickUpDate < ls_order_result-DeliveryDate.

        APPEND VALUE #( %key        = ls_order_result-%key
                        OrderUUID   = ls_order_result-OrderUUID ) TO failed-order.

        APPEND VALUE #( %key     = ls_order_result-%key
                        %msg     = new_message( id       = 'Z_MSG_918'
                                                number   = '002'
                                                v1       = ls_order_result-DeliveryDate
                                                v2       = ls_order_result-PickUpDate
                                                severity = if_abap_behv_message=>severity-error )
                        %element-deliverydate = if_abap_behv=>mk-on
                        %element-pickupdate   = if_abap_behv=>mk-on ) TO reported-order.

      "Check that Delivery date is in the future
      ELSEIF ls_order_result-DeliveryDate < cl_abap_context_info=>get_system_date( ).

        APPEND VALUE #( %key        = ls_order_result-%key
                        OrderUUID   = ls_order_result-OrderUUID ) TO failed-order.

        APPEND VALUE #( %key = ls_order_result-%key
                        %msg = new_message( id       = 'Z_MSG_918'
                                            number   = '001'
                                            v1       = ls_order_result-DeliveryDate
                                            severity = if_abap_behv_message=>severity-error )
                        %element-deliverydate = if_abap_behv=>mk-on ) TO reported-order.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  " Method that delivers an order. That basically means
  " that the status is switched to 'On-Site'.
  METHOD deliverOrder.
    MODIFY ENTITIES OF ZI_ORDER_918_1 IN LOCAL MODE
      ENTITY Order
         UPDATE
           FIELDS ( Status )
           WITH VALUE #( FOR key IN keys
                           ( %tky         = key-%tky
                             Status = order_status-on_site ) )
      FAILED failed
      REPORTED reported.

    " Fill the response table
    READ ENTITIES OF ZI_ORDER_918_1 IN LOCAL MODE
      ENTITY Order
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    result = VALUE #( FOR order IN orders
                        ( %tky   = order-%tky
                          %param = order ) ).
  ENDMETHOD.

  " Method that closes an order. That basically means
  " that the status is switched to 'Closed'.
  METHOD closeOrder.
    MODIFY ENTITIES OF ZI_ORDER_918_1 IN LOCAL MODE
      ENTITY Order
         UPDATE
           FIELDS ( Status )
           WITH VALUE #( FOR key IN keys
                           ( %tky         = key-%tky
                             Status = order_status-closed ) )
      FAILED failed
      REPORTED reported.

    " Fill the response table
    READ ENTITIES OF ZI_ORDER_918_1 IN LOCAL MODE
      ENTITY Order
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    result = VALUE #( FOR order IN orders
                        ( %tky   = order-%tky
                          %param = order ) ).
  ENDMETHOD.

  " Method that reads the status and disables/enables the
  " related action buttons.
  METHOD get_instance_features.
    " Read the order status of the existing orders
    READ ENTITIES OF ZI_ORDER_918_1 IN LOCAL MODE
      ENTITY Order
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders)
      FAILED failed.

    result =
      VALUE #(
        FOR order IN orders
          LET is_open =   COND #( WHEN order-Status = order_status-open
                                      THEN if_abap_behv=>fc-o-enabled
                                      ELSE if_abap_behv=>fc-o-disabled  )
              is_on_site =   COND #( WHEN order-Status = order_status-closed
                                      THEN if_abap_behv=>fc-o-disabled
                                      ELSE if_abap_behv=>fc-o-enabled )
          IN
            ( %tky                 = order-%tky
              %action-deliverOrder = is_open
              %action-closeOrder = is_on_site
             ) ).
  ENDMETHOD.

  " Method that validates the customer ID
  METHOD validateCustomer.
    " Read relevant instance data
    READ ENTITIES OF ZI_ORDER_918_1 IN LOCAL MODE
      ENTITY Order
        FIELDS ( CustomerId ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    DATA customers TYPE SORTED TABLE OF zcustomer_918_1 WITH UNIQUE KEY customer_uuid.

    customers = CORRESPONDING #( orders DISCARDING DUPLICATES MAPPING customer_uuid = CustomerID EXCEPT * ).
    DELETE customers WHERE customer_uuid IS INITIAL.
    IF customers IS NOT INITIAL.
      " Check if customer ID exist
      SELECT FROM zcustomer_918_1 FIELDS customer_uuid
        FOR ALL ENTRIES IN @customers
        WHERE customer_uuid = @customers-customer_uuid
        INTO TABLE @DATA(customers_db).
    ENDIF.

    " Raise error message for non existing and initial customerID
    LOOP AT orders INTO DATA(order).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = order-%tky
                       %state_area = 'VALIDATE_CUSTOMER' )
        TO reported-order.

      IF order-CustomerID IS INITIAL OR NOT line_exists( customers_db[ customer_uuid = order-CustomerId ] ).
        APPEND VALUE #(  %tky = order-%tky ) TO failed-order.

        APPEND VALUE #(  %tky        = order-%tky
                         %state_area = 'VALIDATE_CUSTOMER'
                         %msg        = new_message( id       = 'Z_MSG_918'
                                            number   = '004'
                                            v1       = order-CustomerId
                                            severity = if_abap_behv_message=>severity-error )
                         %element-CustomerID = if_abap_behv=>mk-on )
          TO reported-order.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
