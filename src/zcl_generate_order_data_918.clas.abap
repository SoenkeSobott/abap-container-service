CLASS zcl_generate_order_data_918 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
        INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GENERATE_ORDER_DATA_918 IMPLEMENTATION.


    METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zorder_918.

*   fill internal order table (itab)
    itab = VALUE #(
      ( order_uuid = '12DB768C31731EDB97CFAB9EE9F853C1' id = '0001000211' customer_id = '12DB768C31731EDB97C96DFB942C8C73' description = 'Park container near Garage' status = 'Open'
        delivery_date = '20210210' pick_up_date = '20210215'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
      ( order_uuid = '12DB768C31731EDB97CFAB9EE9F823C1' id = '0002000211' customer_id = '12DB768C31731EDB97C96DFB942C8C73' description = 'Caution with the grass' status = 'Open'
        delivery_date = '20210221' pick_up_date = '20210226'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
      ( order_uuid = '12DB768C31731EDB97CFAB9EE9F813C1' id = '0003000211' customer_id = '12DB768C31731EDB97C96DFB942C8C66' description = 'Pick up at dawn' status = 'Open'
        delivery_date = '20210205' pick_up_date = '20210211'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
      ( order_uuid = '12DB768C31731EDB97CFAB9EE9F873C1' id = '0004000211' customer_id = '12DB768C31731EDB97C96DFB942C8C44' status = 'Open'
        delivery_date = '20210310' pick_up_date = '20210312'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
    ).

*   delete existing entries in the database table
    DELETE FROM zorder_918.

*   insert the new table entries
    INSERT zorder_918 FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } order entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.
