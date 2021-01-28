@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model for customers'
@Search.searchable: true
define root view entity ZI_CUSTOMER_918
  as select from zcustomer_918_1

  /* Associations */
  association [0..*] to ZI_ORDER_918_1 as _Order on $projection.CustomerUUID = _Order.CustomerId

{
  key customer_uuid   as CustomerUUID,
      @Search.defaultSearchElement: true
      id              as Id,
      first_name      as FirstName,
      last_name       as LastName,
      street          as Street,
      city            as City,
      postcode        as Postcode,
      company         as Company,
      contact_person  as ContactPerson,

      /*-- Admin data --*/
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,

      /* Associations */
      _Order
}
