CLASS zcl_gen_cont_map_data_911 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
        INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gen_cont_map_data_911 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zcont_map_918.

*   fill internal order table (itab)
    itab = VALUE #(
      ( map_uuid = '00CC168C31731EDB97CFAB9EE9F853C1' order_uuid = '12DB768C31731EDB97CFAB9EE9F853C1'
        container_uuid = '12DB768C31731EDB97CFAB9EE9F853B1'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
      ( map_uuid = '00CC268C31731EDB97CFAB9EE9F853C1' order_uuid = '12DB768C31731EDB97CFAB9EE9F823C1'
        container_uuid = '12DB768C31731EDB97CFAB9EE9F853B2'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
      ( map_uuid = '00CC368C31731EDB97CFAB9EE9F853C1' order_uuid = '12DB768C31731EDB97CFAB9EE9F813C1'
        container_uuid = '12DB768C31731EDB97CFAB9EE9F853B3'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
      ( map_uuid = '00CC468C31731EDB97CFAB9EE9F853C1' order_uuid = '12DB768C31731EDB97CFAB9EE9F813C1'
        container_uuid = '12DB768C31731EDB97CFAB9EE9F853B4'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
      ( map_uuid = '00CC568C31731EDB97CFAB9EE9F853C1' order_uuid = '12DB768C31731EDB97CFAB9EE9F873C1'
        container_uuid = '12DB768C31731EDB97CFAB9EE9F853B5'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
      ( map_uuid = '00CC668C31731EDB97CFAB9EE9F853C1' order_uuid = '12DB768C31731EDB97CFAB9EE9F873C1'
        container_uuid = '12DB768C31731EDB97CFAB9EE9F853B6'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
      ( map_uuid = '00CC768C31731EDB97CFAB9EE9F853C1' order_uuid = '12DB768C31731EDB97CFAB9EE9F873C1'
        container_uuid = '12DB768C31731EDB97CFAB9EE9F853B7'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
      ( map_uuid = '00CC868C31731EDB97CFAB9EE9F853C1' order_uuid = '12DB768C31731EDB97CFAB9EE9F873C1'
        container_uuid = '12DB768C31731EDB97CFAB9EE9F853B8'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
    ).

*   delete existing entries in the database table
    DELETE FROM zcont_map_918.

*   insert the new table entries
    INSERT zcont_map_918 FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } mapping entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.
