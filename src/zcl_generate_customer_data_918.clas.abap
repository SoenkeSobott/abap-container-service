CLASS zcl_generate_customer_data_918 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
        INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_generate_customer_data_918 IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zcustomer_918_1.

*   fill internal customer table (itab)
    itab = VALUE #(
      ( customer_uuid = '12DB768C31731EDB97C96DFB942C8C73' id = '0001000200' first_name = 'John' last_name = 'Doe'
        street = 'Hilton street 444' city = 'Minneapolis' postcode = '94828'
        created_by = 'MUSTERMANN' created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190702105400.3647680' )
      ( customer_uuid = '12DB768C31731EDB97C96DFB942C8C66' id = '0002000200' first_name = 'Mike' last_name = 'Lerain'
        street = 'Main Avenue 1999' city = 'New York' postcode = '63849'
        company = 'Big Mess Inc.' contact_person = 'The Boss' created_by = 'MUSTERMANN' created_at = '20190613111129.2391370'
        last_changed_by = 'MUSTERMANN' last_changed_at = '20190711140753.1472620' )
      ( customer_uuid = '12DB768C31731EDB97C96DFB942C8C44' id = '0003000200' first_name = 'Nikola' last_name = 'Tesla'
        street = 'Electric Way 101' city = 'New York' postcode = '63849'
        created_by = 'MUSTERMANN' created_at = '20190613105654.4296640' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190613111041.2251330' )
    ).

*   delete existing entries in the database table
    DELETE FROM zcustomer_918_1.

*   insert the new table entries
    INSERT zcustomer_918_1 FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } customer entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.
