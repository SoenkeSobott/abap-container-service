CLASS zcl_gen_waste_type_data_918 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
        INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_gen_waste_type_data_918 IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zwaste_918_1.

*   fill internal waste type table
    itab = VALUE #(
      ( id = '01DB768C31731EDB97CFAB9EE9F853C1' name = 'Bauabfälle (mineralisch)' description = 'Only stones and grave allowed' price_kg = 10
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( id = '02DB768C31731EDB97CFAB9EE9F853C1' name = 'Bauabfälle (gemischt)' description = 'All stone related stuff allowed' price_kg = 20
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( id = '03DB768C31731EDB97CFAB9EE9F853C1' name = 'Holz' description = 'Only wood' price_kg = 15
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( id = '04DB768C31731EDB97CFAB9EE9F853C1' name = 'Metall' description = 'Only metal' price_kg = 15
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( id = '05DB768C31731EDB97CFAB9EE9F853C1' name = 'Schrott' description = 'Can be mixture of all categries' price_kg = 30
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( id = '06DB768C31731EDB97CFAB9EE9F853C1' name = 'Kunststoffhaltige Bauabfälle' description = 'Only plastic' price_kg = 10
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( id = '07DB768C31731EDB97CFAB9EE9F853C1' name = 'Erde' description = 'Only naturals' price_kg = 20
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
      ( id = '08DB768C31731EDB97CFAB9EE9F853C1' name = 'Boden' description = 'Boden halt :D' price_kg = 25
        created_by = 'MUSTERMANN' created_at = '20200702105400.3647680' last_changed_by = 'MUSTERFRAU' last_changed_at = '20200702105400.3647680' )
    ).

*   delete existing entries in the database table
    DELETE FROM zwaste_918_1.

*   insert the new table entries
    INSERT zwaste_918_1 FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } waste type entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.
