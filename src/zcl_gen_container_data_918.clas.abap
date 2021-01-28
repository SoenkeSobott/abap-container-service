CLASS zcl_gen_container_data_918 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
        INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gen_container_data_918 IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zcontainer_918_1.

*   fill internal container table
    itab = VALUE #(
      ( container_uuid = '12DB768C31731EDB97CFAB9EE9F853B1' waste_type_id = '01DB768C31731EDB97CFAB9EE9F853C1'
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( container_uuid = '12DB768C31731EDB97CFAB9EE9F853B2' waste_type_id = '02DB768C31731EDB97CFAB9EE9F853C1'
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( container_uuid = '12DB768C31731EDB97CFAB9EE9F853B3'  waste_type_id = '03DB768C31731EDB97CFAB9EE9F853C1'
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( container_uuid = '12DB768C31731EDB97CFAB9EE9F853B4' waste_type_id = '04DB768C31731EDB97CFAB9EE9F853C1'
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( container_uuid = '12DB768C31731EDB97CFAB9EE9F853B5' waste_type_id = '05DB768C31731EDB97CFAB9EE9F853C1'
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( container_uuid = '12DB768C31731EDB97CFAB9EE9F853B6' waste_type_id = '06DB768C31731EDB97CFAB9EE9F853C1'
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( container_uuid = '12DB768C31731EDB97CFAB9EE9F853B7' waste_type_id = '07DB768C31731EDB97CFAB9EE9F853C1'
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( container_uuid = '12DB768C31731EDB97CFAB9EE9F853B8' waste_type_id = '08DB768C31731EDB97CFAB9EE9F853C1'
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
    ).

*   delete existing entries in the database table
    DELETE FROM zcontainer_918_1.

*   insert the new table entries
    INSERT zcontainer_918_1 FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } container entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.
