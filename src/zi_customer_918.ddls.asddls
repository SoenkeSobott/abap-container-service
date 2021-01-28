@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model for customers'
@Search.searchable: true
define root view entity ZI_CUSTOMER_918
  as select from zcustomer_918_1
  
  //composition [0..*] of ZI_ORDER_918_1 as _Order
  
  association [0..*] to ZI_ORDER_918_1 as _Order on $projection.CustomerUUID = _Order.CustomerId

{
      @Search.defaultSearchElement: true
  key customer_uuid   as CustomerUUID,
      @Search.defaultSearchElement: true
      id              as Id,
      @Search.defaultSearchElement: true
      first_name      as FirstName,
      @Search.defaultSearchElement: true
      last_name       as LastName,
      address         as Address,
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

      _Order
}
